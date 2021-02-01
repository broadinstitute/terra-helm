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
| bitnami.arbiter.enabled | bool | `false` |  |
| bitnami.architecture | string | `"replicaset"` |  |
| bitnami.auth.database | string | `"agora"` |  |
| bitnami.auth.existingSecret | string | `"mongodb-secrets"` |  |
| bitnami.auth.username | string | `"agora"` |  |
| bitnami.fullnameOverride | string | `"mongodb"` |  |
| bitnami.image.tag | string | `"4.4.3"` |  |
| bitnami.persistence.annotations."bio.terra/snapshot-policy" | string | `"terra-snapshot-policy"` |  |
| bitnami.persistence.size | string | `"50Gi"` |  |
| bitnami.replicaCount | int | `3` |  |
| bitnami.resources.limits.cpu | int | `4` |  |
| bitnami.resources.limits.memory | string | `"25Gi"` |  |
| bitnami.resources.requests.cpu | int | `4` |  |
| bitnami.resources.requests.memory | string | `"25Gi"` |  |
| bitnami.serviceAccount.create | bool | `false` |  |
| bitnami.serviceAccount.name | string | `"mongodb-sa"` |  |
| bitnami.volumePermissions.enabled | bool | `true` |  |
| global.storageClass | string | `"terra-standard"` |  |
| name | string | `"mongodb"` | the name of the service deployed by this chart. Defaults to "mongodb". If this value is overridden, be careful to also update the bitnami subchart values to match! |
| vaultAgoraPasswordKey | string | `nil` | What key in Vault contains agora user's MongoDB password |
| vaultAgoraPasswordPath | string | `nil` | Where in Vault the agora user's MongoDB password is stored |
| vaultSecretsPath | string | `nil` | Where in Vault to find secrets used by MongoDB chart. Required keys: `replicaSetKey`, `rootPassword`, `userPassword` |
