#!/bin/bash

# A silly script for dumping data from the legacy Mongo installation

set -e
set -o pipefail

PROMPT=${PROMPT:-true}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

prompt(){
  if [[ "${PROMPT}" != "false" ]]; then
    echo "> $@"
    read -p "Proceed? (N/y): " answer
    echo
    if [[ "${answer}" != "y" ]]; then
      echo "Exiting."
      exit 1
    fi
  fi
  "$@"
}

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <env>" >&2
  exit 1
fi

export VAULT_ADDR=https://clotho.broadinstitute.org:8200

ENV="$1"

if [[ ! $ENV =~ ^(dev|perf|alpha|staging|prod)$ ]]; then
  echo "Unknown env: ${ENV}" >&2
  exit 1
fi

K8S_LOCATION="--zone=us-central1-a"

if [[ "${ENV}" == "prod" ]]; then
  K8S_LOCATION="--region=us-central1"
fi

PROJECT="broad-dsde-${ENV}"
CLUSTER="terra-${ENV}"
NAMESPACE="terra-${ENV}"
TLD="dsde-${ENV}.broadinstitute.org"
PODNAME="ch-mongodb-dump"
TIMESTAMP="$( date '+%Y%m%d.%H%M%S' )"
DUMPFILE="mongodb-${TIMESTAMP}.tgz"
LOCAL_DUMPFILE="mongodb-${TIMESTAMP}.$$.tgz"
GCS_UPLOAD_PATH="gs://mongodb-backups-dsp-terra-${ENV}/k8s-cutover/${DUMPFILE}"

AGORA_MONGODB_PASSWORD=$( set +x; vault read -field mongodb_password secret/dsde/firecloud/${ENV}/agora/secrets )

list_mongodb_instances(){
  gcloud compute instances list \
    --project="${PROJECT}" \
    --limit=2 \
    --filter="status:RUNNING AND name~'mongodb' AND NOT name~'arbiter' AND NOT name~'gke'" \
    --format="table[no-heading]value[separator=\",\"](name,networkInterfaces.accessConfigs[0].natIP)"
}

MONGO1_ADDR=
MONGO1_ALIAS=
MONGO2_ADDR=
MONGO2_ALIAS=

while read line; do
  hostname=$( echo $line | cut -d, -f1 )
  address=$( echo $line | cut -d, -f2 )

  if [[ -z "${MONGO1_ADDR}" ]]; then
    echo "mongo1: ${address} (${hostname})"
    MONGO1_ADDR="${address}"
    MONGO1_HOSTNAME="${hostname}"
  elif [[ -z "${MONGO2_ADDR}" ]]; then
    echo "mongo2: ${address} (${hostname})"
    MONGO2_ADDR="${address}"
    MONGO2_HOSTNAME="${hostname}"
  else
    echo "Too many addresses!" >&2
    exit 1
  fi
done <<< "$( list_mongodb_instances )"

OVERRIDES=$( cat <<JSON
{
  "spec": {
    "hostAliases": [
      {
        "ip": "${MONGO1_ADDR}",
        "hostnames":[
          "${MONGO1_HOSTNAME}",
          "mongodb01.${TLD}"
        ]
      },
      {
        "ip": "${MONGO2_ADDR}",
        "hostnames":[
          "${MONGO2_HOSTNAME}",
          "mongodb02.${TLD}"
        ]
      }
    ]
  }
}
JSON
)

echo "Authenticating to cluster ${CLUSTER} in ${PROJECT}"
gcloud container clusters get-credentials "${K8S_LOCATION}" --project="${PROJECT}" "${CLUSTER}"

echo "Launching dump pod ${PODNAME} in ${NAMESPACE}"
kubectl -n "${NAMESPACE}" \
  run \
  --env="MONGODB_PASSWORD=${AGORA_MONGODB_PASSWORD}" \
  --overrides "$OVERRIDES" \
  --image mongo:latest \
  "${PODNAME}" -- bash -c 'sleep 600'

trap "set -x; echo killing $PODNAME; kubectl -n ${NAMESPACE} delete --now pod ${PODNAME}" EXIT

echo "Waiting 30s for the pod to start"
sleep 30

echo "Uploading collectionCounts.js to pod"
kubectl -n "${NAMESPACE}" \
  cp "${DIR}/collectionCounts.js" "${PODNAME}:/tmp/collectionCounts.js"

echo "Running collectionCounts.js..."
kubectl -n "${NAMESPACE}" \
  exec "${PODNAME}" -- \
  bash -c \
  "mongo --password \$MONGODB_PASSWORD 'mongodb://agora@mongodb01.${TLD}:27017,mongodb02.${TLD}:27017/agora?replicaSet=rs0' /tmp/collectionCounts.js"

echo "Dumping Agora MongoDB data"
prompt kubectl -n "${NAMESPACE}" \
  exec "${PODNAME}" -- \
  bash -c \
  "mongodump --password \$MONGODB_PASSWORD 'mongodb://agora@mongodb01.${TLD}:27017,mongodb02.${TLD}:27017/agora?replicaSet=rs0'"

kubectl -n "${NAMESPACE}" \
  exec "${PODNAME}" -- \
  bash -c \
  "tar -czvf ${DUMPFILE} dump"

kubectl -n "${NAMESPACE}" \
  cp "${PODNAME}:/${DUMPFILE}" "${LOCAL_DUMPFILE}"

echo "Uploading /tmp/${DUMPFILE} to ${GCS_UPLOAD_PATH}"
gsutil cp "${LOCAL_DUMPFILE}" "${GCS_UPLOAD_PATH}"

cat <<EOF

Dump from ${ENV} MongoDB vms is complete!

To import into GKE MongoDB in the same environment, run:
  mongo-import.sh ${ENV} ${TIMESTAMP}

EOF
