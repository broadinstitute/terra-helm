# On local machine:

TERRA_ENV=dev
OPENDJ_PASSWORD=$(docker run \
  --rm \
  --cap-add IPC_LOCK \
  -e "VAULT_TOKEN=$(cat ~/.vault-token)" \
  -e "VAULT_ADDR=https://clotho.broadinstitute.org:8200" \
  vault:1.1.0 vault read \
    -field=ldap_password \
    "secret/dsde/firecloud/${TERRA_ENV}/sam/sam.conf")

kubectl apply \
 --namespace "terra-${TERRA_ENV}" \
 --filename gcloud-pod.yaml

kubectl exec \
  --namespace "terra-${TERRA_ENV}" \
  --tty \
  --stdin \
  gcloud-temp \
  --container gcloud -- /bin/bash

# In the container:

TERRA_ENV=dev
BACKUP_NAME="backup-20210308.182024.tgz"
OPENDJ_PASSWORD="[Insert value from local var]"

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

# Restore config files
kubectl exec \
  --namespace "terra-${TERRA_ENV}" \
  --tty \
  --stdin \
  opendj-statefulset-0 \
  -c opendj -- /bin/bash -c "cp -R /opt/opendj/data/restore/config /opt/opendj/data"

# Restart OpenDJ
kubectl --namespace "terra-${TERRA_ENV}" scale --replicas=0 sts opendj-statefulset
kubectl --namespace "terra-${TERRA_ENV}" scale --replicas=1 sts opendj-statefulset

# Re-create (if needed) and re-build indexes
curl -LJO https://raw.githubusercontent.com/broadinstitute/terra-helm/master/charts/opendj/scripts/restore/indexes.sh
chmod +x indexes.sh
./indexes.sh

# Set up backup
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
