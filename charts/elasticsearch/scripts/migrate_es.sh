#!/bin/bash

set -e
set -o pipefail

ENV="$1"

if [[ ! $ENV =~ ^(dev|perf|alpha|staging|prod)$ ]]; then
  echo "Unknown env: ${ENV}" >&2
  exit 1
fi

K8S_LOCATION="--zone=us-central1-a"

if [[ "${ENV}" == "prod" ]]; then
  K8S_LOCATION="--region=us-central1"
fi

CLUSTER="terra-${ENV}"
NAMESPACE="terra-${ENV}"
PODNAME="mf-es-migration"
PROJECT="broad-dsde-${ENV}"

echo "Authenticating to cluster ${CLUSTER} in ${PROJECT}"
gcloud container clusters get-credentials "${K8S_LOCATION}" --project="${PROJECT}" "${CLUSTER}"

echo "Launching es migration pod: ${PODNAME} in namespace: ${NAMESPACE}"
kubectl -n "${NAMESPACE}" \
run \
--env="ES_DUMP_SOURCE=http://elasticsearch5a2.dsde-${ENV}.broadinstitute.org:9200" \
--env="ES_DUMP_TARGET=http://elasticsearch5a-master:9200" \
--restart="Never" \
--image gcr.io/dsp-artifact-registry/elasticsearch-migration:latest \
"${PODNAME}"

echo "waiting 15 secs for the pod to start"
sleep 15

echo "tailing elastic dump logs"
kubectl logs --follow -n "${NAMESPACE}" "${PODNAME}" 

echo "elasticdump complete"

echo "shutting down pod: ${PODNAME}"
kubectl delete pod -n "${NAMESPACE}" "${PODNAME}"

echo "elasticsearch data migration complete, exiting..."
