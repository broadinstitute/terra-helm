mongodb
=======

A Helm chart for MongoDB, used by Terra's Agora application.
This chart is heavily customized to Terra's needs and is a thin wrapper around Bitnami's MongoDB Helm chart.


## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mongodb | 10.5.1 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backup.cloudsdkImage.repository | string | `"gcr.io/google.com/cloudsdktool/cloud-sdk"` | Image tag to use for Cloud SDK |
| backup.cloudsdkImage.tag | string | `"326.0.0-alpine"` |  |
| backup.enabled | bool | `false` | Whether to automatically back up MongoDB with a nightly mongodump + copy to GCP bucket |
| backup.gcsBucket | string | `nil` | Name of the GCS bucket where backups should be copied |
| backup.nodeSelector | object | `{}` | NodeSelector for backup CronJob pods |
| backup.timeoutSeconds | int | `7200` | How many seconds to wait before assuming job is hung and killing it |
| backup.tolerations | list | `[]` | Tolerations for backup CronJob pods |
| bitnami.arbiter.enabled | bool | `false` |  |
| bitnami.architecture | string | `"replicaset"` |  |
| bitnami.auth.database | string | `"agora"` |  |
| bitnami.auth.existingSecret | string | `"mongodb-secrets"` |  |
| bitnami.auth.username | string | `"agora"` |  |
| bitnami.fullnameOverride | string | `"mongodb"` |  |
| bitnami.image.repository | string | `"bitnami/mongodb"` |  |
| bitnami.image.tag | string | `"4.4.3-debian-10-r31"` |  |
| bitnami.labels."app.kubernetes.io/instance" | string | `"mongodb"` |  |
| bitnami.labels."app.kubernetes.io/name" | string | `"mongodb"` |  |
| bitnami.labels."app.kubernetes.io/part-of" | string | `"terra"` |  |
| bitnami.persistence.annotations."bio.terra/snapshot-policy" | string | `"terra-snapshot-policy"` |  |
| bitnami.persistence.size | string | `"125Gi"` |  |
| bitnami.podLabels."app.kubernetes.io/instance" | string | `"mongodb"` |  |
| bitnami.podLabels."app.kubernetes.io/part-of" | string | `"terra"` |  |
| bitnami.replicaCount | int | `3` |  |
| bitnami.resources.limits.cpu | string | `"3250m"` |  |
| bitnami.resources.limits.memory | string | `"21Gi"` |  |
| bitnami.resources.requests.cpu | string | `"3250m"` |  |
| bitnami.resources.requests.memory | string | `"21Gi"` |  |
| bitnami.serviceAccount.create | bool | `false` |  |
| bitnami.serviceAccount.name | string | `"mongodb-sa"` |  |
| bitnami.volumePermissions.enabled | bool | `true` |  |
| expose | bool | `false` | Whether to expose MongoDB outside the cluster. This is only for backwards-compatibility with existing Terra dev workflows; avoid enabling in new environments |
| exposeIPs | list | `[]` | Static public IPs to assign to replicas. Required if expose is `true`; must match the number of replicas. Eg. ["1.2.3.4", "5.6.7.8", "9.10.11.12"]. |
| global.storageClass | string | `"terra-xfs-zonal"` | Storage class to use when provisioning persistent disks (passed to Bitnami chart) |
| global.trustedAddresses | object | `{}` | A map of addesses that should be permitted to connect to MongoDB (see `expose` value). Example: `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
| name | string | `"mongodb"` | The name of the service deployed by this chart. Defaults to "mongodb". If this value is overridden, be careful to also update the bitnami subchart values below to match! |
| vaultSecrets | object | `{"agoraPassword":{"key":null,"path":null},"backupCredentials":{"key":null,"path":null},"replicaSetKey":{"key":null,"path":null},"rootPassword":{"key":null,"path":null}}` | Where in Vault to find secrets used by MongoDB chart. |
| vaultSecrets.agoraPassword.key | string | `nil` | Key in Vault where the Agora password is stored |
| vaultSecrets.agoraPassword.path | string | `nil` | Path in Vault the Agora password is stored |
| vaultSecrets.backupCredentials.key | string | `nil` | Key in Vault where base64-encoded GCP service account key for backups is stored |
| vaultSecrets.backupCredentials.path | string | `nil` | Path in Vault where base64-encoded GCP service account key for backups is stored |
| vaultSecrets.replicaSetKey.key | string | `nil` | Key in Vault where the MongoDB replica set key is stored |
| vaultSecrets.replicaSetKey.path | string | `nil` | Path in Vault the MongoDB replica set key is stored |
| vaultSecrets.rootPassword.key | string | `nil` | Key in Vault where the MongoDB root password is stored |
| vaultSecrets.rootPassword.path | string | `nil` | Path in Vault the MongoDB root password is stored |
