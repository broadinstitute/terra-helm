#!/bin/bash

# A silly script for importing data into the new GKE Mongo installation

set -e
set -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

PROMPT=${PROMPT:-true}

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

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <env> <timestamp>" >&2
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


TIMESTAMP="$2"
PROJECT="broad-dsde-${ENV}"
CLUSTER="terra-${ENV}"
NAMESPACE="terra-${ENV}"
TLD="dsde-${ENV}.broadinstitute.org"
PODNAME="ch-mongodb-import"
DUMPFILE="mongodb-${TIMESTAMP}.tgz"
LOCAL_DUMPFILE="/tmp/mongodb-${TIMESTAMP}.$$.tgz"
GCS_UPLOAD_PATH="gs://mongodb-backups-dsp-terra-${ENV}/k8s-cutover/${DUMPFILE}"

AGORA_MONGODB_PASSWORD=$( set +x; vault read -field mongodb_password secret/dsde/firecloud/${ENV}/agora/secrets )

echo "Authenticating to cluster ${CLUSTER} in ${PROJECT}"
gcloud container clusters get-credentials "${K8S_LOCATION}" --project="${PROJECT}" "${CLUSTER}"

echo "Launching import pod ${PODNAME} in ${NAMESPACE}"
kubectl -n "${NAMESPACE}" \
  run \
  --env="MONGODB_PASSWORD=${AGORA_MONGODB_PASSWORD}" \
  --image mongo:latest \
  "${PODNAME}" -- bash -c 'sleep 600'

trap "set -x; echo killing $PODNAME; kubectl -n ${NAMESPACE} delete --now pod ${PODNAME}" EXIT

echo "Waiting 15s for the pod to start"
sleep 15


echo "Uploading collectionCounts.js to pod"
kubectl -n "${NAMESPACE}" \
  cp "${DIR}/collectionCounts.js" "${PODNAME}:/tmp/collectionCounts.js"

echo "Downloading dump file to /tmp/${DUMPFILE} from ${GCS_UPLOAD_PATH}"
gsutil cp "${GCS_UPLOAD_PATH}" "${LOCAL_DUMPFILE}"

echo "Uploading dump file to pod"
kubectl -n "${NAMESPACE}" \
  cp "${LOCAL_DUMPFILE}" "${PODNAME}:/tmp/${DUMPFILE}"

echo "Unpacking dump file in pod"
kubectl -n "${NAMESPACE}" \
  exec "${PODNAME}" -- \
  bash -c \
  "tar -xzvf /tmp/${DUMPFILE}"

echo "Importing Agora MongoDB data"
prompt kubectl -n "${NAMESPACE}" \
  exec "${PODNAME}" -- \
  bash -c \
  "mongorestore --password \$MONGODB_PASSWORD --drop --authenticationDatabase agora --dir dump/agora 'mongodb://agora@mongodb-0.mongodb-headless:27017,mongodb-1.mongodb-headless:27017,mongodb-2.mongodb-headless:27017/agora?replicaSet=rs0'"

echo "Running collectionCounts.js..."
kubectl -n "${NAMESPACE}" \
  exec "${PODNAME}" -- \
  bash -c \
  "mongo --password \$MONGODB_PASSWORD 'mongodb://agora@mongodb-0.mongodb-headless:27017,mongodb-1.mongodb-headless:27017,mongodb-2.mongodb-headless:27017/agora?replicaSet=rs0' /tmp/collectionCounts.js"

echo "Import completed."
