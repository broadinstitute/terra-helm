# poc

Chart for a POC Terra app

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://broadinstitute.github.io/terra-helm/ | postgres | 0.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certManager.duration | string | `"2160h0m0s"` | Certificate duration. Defaults to 3 months. |
| certManager.enabled | bool | `false` | Enable to create certificate secret with cert-manager |
| certManager.issuerKind | string | `"ClusterIssuer"` |  |
| certManager.issuerName | string | `"cert-manager-letsencrypt-prod"` |  |
| certManager.renewBefore | string | `"360h0m0s"` | When to renew the cert. Defaults to 15 days before expiry. |
| domain.hostname | string | `"poc"` | Hostname of this deployment |
| domain.namespaceEnv | bool | `true` | If true, an extra level of namespacing (`global.terraEnv`) will be added between the hostname and suffix |
| domain.suffix | string | `"integ.envs.broadinstitute.org"` | Domain suffix |
| global.applicationVersion | string | Is set by Helmfile on deploy | image version/tag. Required unless using `image`. |
| global.terraEnv | string | Is set by Helmfile on deploy | Terget Terra environment name. Required. |
| image | string | Is set by Skaffold on local deploys | Used for local Skaffold deploys |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"gcr.io/terra-kernel-k8s/kernel-service-poc"` | Image repository |
| imageConfig.tag | string | The chart's appVersion value will be used | Image tag. |
| postgres.dbs | list | `["poc"]` | (array(string)) List of databases to create. |
| postgres.enabled | bool | `false` | Whether to enable ephemeral Postgres container. Used for preview/test environments. See the postgres chart for more config options. |
| proxy.enabled | bool | `true` |  |
| proxy.image.repository | string | `"broadinstitute/openidc-proxy"` | Proxy image repository |
| proxy.image.version | string | `"bernick_tcell"` | Proxy image tag |
| proxy.logLevel | string | `"debug"` | Proxy log level |
| replicas | int | `1` |  |
| serviceIP | string | `nil` | External IP of the service. Required. |
| vault.enabled | bool | `true` | When enabled, syncs required secrets from Vault |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
| vaultCert.cert.path | string | `nil` | Path to secret containing .crt |
| vaultCert.cert.secretKey | string | `nil` | Key in secret containing .crt |
| vaultCert.chain.path | string | `nil` | Path to secret containing intermediate .crt |
| vaultCert.chain.secretKey | string | `nil` | Key in secret containing intermediate .crt |
| vaultCert.enabled | bool | `false` | Enable to sync certificate secret from Vault with secrets-manager |
| vaultCert.key.path | string | `nil` | Path to secret containing .key |
| vaultCert.key.secretKey | string | `nil` | Key in secret containing .key |
