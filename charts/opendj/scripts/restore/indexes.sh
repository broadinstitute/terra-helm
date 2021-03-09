#!/bin/bash

: "${TERRA_ENV?Need to set TERRA_ENV}"
: "${OPENDJ_PASSWORD?Need to set OPENDJ_PASSWORD}"

create_index() {
  ATTRIBUTE=$1
  echo "creating index $ATTRIBUTE"
  kubectl exec \
    --namespace "terra-${TERRA_ENV}" \
    --tty \
    --stdin \
    opendj-statefulset-0 \
    -c opendj -- /bin/bash -c "/opt/opendj/bin/dsconfig create-backend-index \
      --hostname localhost  \
      --port 4444  \
      --bindDN \"cn=Directory Manager\" \
      --bindPassword ${OPENDJ_PASSWORD} \
      --backend-name userRoot \
      --set index-type:equality \
      --type generic \
      --index-name $ATTRIBUTE \
      --trustAll \
      --no-prompt"
  
  EXIT_CODE=$?

  # if [ $EXIT_CODE = 0 ]; then
  if [ 0 = 0 ]; then
    echo "created index $ATTRIBUTE, rebuilding index"
    kubectl exec \
      --namespace "terra-${TERRA_ENV}" \
      --tty \
      --stdin \
      opendj-statefulset-0 \
      -c opendj -- /bin/bash -c "/opt/opendj/bin/rebuild-index \
        --hostname localhost  \
        --port 4444  \
        --bindDN \"cn=Directory Manager\" \
        --bindPassword ${OPENDJ_PASSWORD} \
        --baseDN dc=dsde-${TERRA_ENV},dc=broadinstitute,dc=org \
        --index $ATTRIBUTE \
        --trustAll"
  else
    echo "index $ATTRIBUTE already exists, not rebuilding index"
  fi
}

create_index googleSubjectId
create_index public
create_index resourceId
