# Below are the steps to restore a Terra OpenDJ from a backup. This script is not meant to
#   be run all at once, but to be used as a reference and copy-pasted from, since it does 
#   not have any error handling or any other fancy stuff like that.

#####################
# On local machine: #
#####################

TERRA_ENV="[Terra environment (dev/perf/alpha/staging/prod)]"
OPENDJ_PASSWORD=$(docker run \
  --rm \
  --cap-add IPC_LOCK \
  -e "VAULT_TOKEN=$(cat ~/.vault-token)" \
  -e "VAULT_ADDR=https://clotho.broadinstitute.org:8200" \
  vault:1.1.0 vault read \
    -field=ldap_password \
    "secret/dsde/firecloud/${TERRA_ENV}/sam/sam.conf")

# Spin up Google Cloud SDK container in the Terra k8s cluster to work in
kubectl apply \
 --namespace "terra-${TERRA_ENV}" \
 --filename gcloud-pod.yaml

# SSH into the container
kubectl exec \
  --namespace "terra-${TERRA_ENV}" \
  --tty \
  --stdin \
  gcloud-temp \
  --container gcloud -- /bin/bash

#####################
# In the container: #
#####################

BACKUP_NAME="[name of backup archive from bucket]"
export TERRA_ENV="[environment (dev/perf/alpha/staging/prod)]"
export OPENDJ_PASSWORD="[Insert value from local machine var above]"

gcloud auth activate-service-account --key-file=/sa-key.json

gcloud container clusters get-credentials \
  --internal-ip \
  "terra-${TERRA_ENV}" \
  --zone us-central1-a \
  --project "broad-dsde-${TERRA_ENV}"

gsutil cp "gs://opendj-backups-dsp-terra-${TERRA_ENV}/${BACKUP_NAME}" backup.tgz

tar -xzvf backup.tgz

kubectl cp \
  "backup" \
  "terra-${TERRA_ENV}/opendj-statefulset-0:/opt/opendj/data/restore"

# Restore data
kubectl exec \
  --namespace "terra-${TERRA_ENV}" \
  --tty \
  --stdin \
  opendj-statefulset-0 \
  -c opendj -- /bin/bash -c "/opt/opendj/bin/restore \
    --hostname localhost  \
    --port 4444  \
    --bindDN \"cn=Directory Manager\" \
    --bindPassword ${OPENDJ_PASSWORD} \
    --backupDirectory /opt/opendj/data/restore/userRoot \
    --trustAll"

# Restore schema
kubectl exec \
  --namespace "terra-${TERRA_ENV}" \
  --tty \
  --stdin \
  opendj-statefulset-0 \
  -c opendj -- /bin/bash -c "/opt/opendj/bin/restore \
    --hostname localhost  \
    --port 4444  \
    --bindDN \"cn=Directory Manager\" \
    --bindPassword ${OPENDJ_PASSWORD} \
    --backupDirectory /opt/opendj/data/restore/schema \
    --trustAll"

# Restart OpenDJ
kubectl --namespace "terra-${TERRA_ENV}" scale --replicas=0 sts opendj-statefulset
kubectl --namespace "terra-${TERRA_ENV}" scale --replicas=1 sts opendj-statefulset

# Wait for it to start up and become healthy in ArgoCD

# Re-create (if needed) and re-build indexes
curl -LJO https://raw.githubusercontent.com/broadinstitute/terra-helm/master/charts/opendj/scripts/restore/indexes.sh
chmod +x indexes.sh
./indexes.sh

# Set up backup to run daily at 2 AM
# Ideally we would just restore the tasks backend but that is not possible without stopping OpenDJ
kubectl exec \
  --namespace "terra-${TERRA_ENV}" \
  --tty \
  --stdin \
  opendj-statefulset-0 \
  -c opendj -- /bin/bash -c "/opt/opendj/bin/backup \
    --hostname localhost  \
    --port 4444  \
    --bindDN \"cn=Directory Manager\" \
    --bindPassword ${OPENDJ_PASSWORD} \
    --backUpAll \
    --backupDirectory /opt/opendj/data/bak \
    --recurringTask \"00 02 * * *\" \
    --compress \
    --backupId $(date "+%m%d%Y") \
    --trustAll"

# Make sure backup task is scheduled
kubectl exec \
  --namespace "terra-${TERRA_ENV}" \
  --tty \
  --stdin \
  opendj-statefulset-0 \
  -c opendj -- /bin/bash -c "/opt/opendj/bin/manage-tasks \
    --hostname localhost  \
    --port 4444  \
    --bindDN \"cn=Directory Manager\" \
    --bindPassword ${OPENDJ_PASSWORD} \
    --summary \
    --trustAll"

# Leave container
exit

#####################
# On local machine: #
#####################

# Clean up the Cloud SDK pod
kubectl -n "terra-${TERRA_ENV}" delete pod gcloud-temp

# Sanity checks:

# Count people
ldapsearch \
  -LLL \
  -H "ldaps://opendj-k8s.dsde-${TERRA_ENV}.broadinstitute.org" \
  -D "cn=Directory Manager" \
  -w "${OPENDJ_PASSWORD}" \
  -b "ou=people,dc=dsde-${TERRA_ENV},dc=broadinstitute,dc=org" \
| egrep -c '^dn'

# Make sure proxy user can look do ldapsearch
PROXY_PASSWORD=$(docker run \
  --rm \
  --cap-add IPC_LOCK \
  -e "VAULT_TOKEN=$(cat ~/.vault-token)" \
  -e "VAULT_ADDR=https://clotho.broadinstitute.org:8200" \
  vault:1.1.0 vault read \
    -field=proxy_ldap_bind_password \
    "secret/dsde/firecloud/${TERRA_ENV}/common/proxy-ldap")
ldapsearch \
  -LLL \
  -H "ldaps://opendj-k8s.dsde-${TERRA_ENV}.broadinstitute.org" \
  -D "cn=proxy-ro,ou=people,dc=dsde-${TERRA_ENV},dc=broadinstitute,dc=org" \
  -w "${PROXY_PASSWORD}" \
  -b "ou=people,dc=dsde-${TERRA_ENV},dc=broadinstitute,dc=org" \
  "(googleSubjectId=103858679565563386175)"

# All done!
