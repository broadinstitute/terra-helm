mongodb
=======
A Helm chart for MongoDB, used by Terra's Agora application

Current chart version is `0.0.1`



## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mongodb | 9.2.2 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| bitnami.auth.existingSecret | string | `"mongodb-creds"` |  |
| vaultSecretsPath | string | `nil` | Where in Vault to find secrets used in this chart. Required keys: `replicaSetKey`, `rootPassword`, `userPassword` |
