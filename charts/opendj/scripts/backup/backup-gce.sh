# Below are the steps to back up a GCE Terra OpenDJ. This script is not meant to
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

# Create backup directory
gcloud beta compute ssh \
  --zone "us-central1-a" \
  --project "broad-dsde-${TERRA_ENV}" \
  "gce-opendj-${TERRA_ENV}101" \
  --command \
    "sudo mkdir /local/opendj_data/bak/backup"

# Backup
gcloud beta compute ssh \
  --zone "us-central1-a" \
  --project "broad-dsde-${TERRA_ENV}" \
  "gce-opendj-${TERRA_ENV}101" \
  --command \
    "sudo docker exec opendj_opendj_1 /opt/opendj/bin/backup \
      --hostname localhost  \
      --port 4444  \
      --bindDN \"cn=Directory Manager\" \
      --bindPassword ${OPENDJ_PASSWORD} \
      --backUpAll \
      --backupDirectory /opt/opendj/data/bak/backup \
      --compress \
      --trustAll"

# Set permissions on backup files
gcloud beta compute ssh \
  --zone "us-central1-a" \
  --project "broad-dsde-${TERRA_ENV}" \
  "gce-opendj-${TERRA_ENV}101" \
  --command \
    "sudo chmod -R 775 /local/opendj_data/bak/backup"

# Compress backup
gcloud beta compute ssh \
  --zone "us-central1-a" \
  --project "broad-dsde-${TERRA_ENV}" \
  "gce-opendj-${TERRA_ENV}101" \
  --command \
    "sudo tar -C /local/opendj_data/bak -cvzf /local/opendj_data/bak/backup.tgz backup"

# SSH to GCE VM
gcloud beta compute ssh \
  --zone "us-central1-a" \
  --project "broad-dsde-${TERRA_ENV}" \
  "gce-opendj-${TERRA_ENV}101"

##############
# On GCE VM: #
##############

# Auth gcloud. Project: broad-dsde-[TERRA_ENV], zone: us-central1-a
gcloud init

# Copy backup to bucket
TERRA_ENV="[Terra environment (dev/perf/alpha/staging/prod)]"
TIMESTAMP=$( date "+%Y%m%d.%H%M%S" )
gsutil cp /local/opendj_data/bak/backup.tgz "gs://opendj-backups-dsp-terra-${TERRA_ENV}/backup-${TIMESTAMP}.tgz"

# Log out of gcloud
gcloud auth revoke
