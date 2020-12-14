# workspacemanager

Chart for Terra Workspace Manager

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://broadinstitute.github.io/terra-helm/ | postgres | 0.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appVersion | string | Is set by Helmfile on deploy | Workspace Manager image version/tag. Required unless using `image`. |
| certManager.duration | string | `"2160h0m0s"` | Certificate duration. Defaults to 3 months. |
| certManager.enabled | bool | `false` | Enable to create certificate secret with cert-manager |
| certManager.issuerKind | string | `"ClusterIssuer"` |  |
| certManager.issuerName | string | `"cert-manager-letsencrypt-prod"` |  |
| certManager.renewBefore | string | `"360h0m0s"` | When to renew the cert. Defaults to 15 days before expiry. |
| cloudTraceEnabled | bool | `true` | Whether to enable gcp cloud trace |
| domain.hostname | string | `"workspace"` | Hostname of this deployment |
| domain.namespaceEnv | bool | `true` | If true, an extra level of namespacing (`global.terraEnv`) will be added between the hostname and suffix |
| domain.suffix | string | `"integ.envs.broadinstitute.org"` | Domain suffix |
| global.terraEnv | string | Is set by Helmfile on deploy | Terget Terra environment name. Required. |
| global.trustedAddresses | object | `{}` | A map of addresses that will be merged with serviceAllowedAddresses. Example: `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
| googleFolderId | string | `nil` | the id of the Google Folder to create projects for workspaces within. |
| image | string | Is set by Skaffold on local deploys | Used for local Skaffold deploys |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"gcr.io/terra-kernel-k8s/terra-workspace-manager"` | Image repository |
| imageConfig.tag | string | The chart's appVersion value will be used | Image tag. |
| initDB | bool | `false` | Whether the WSM and Stairway DBs should be initialized on startup. Used for preview environments. |
| postgres.dbs | list | `["workspace","stairway"]` | (array(string)) List of databases to create. |
| postgres.enabled | bool | `false` | Whether to enable ephemeral Postgres container. Used for preview/test environments. See the postgres chart for more config options. |
| proxy.enabled | bool | `true` |  |
| proxy.image.repository | string | `"broadinstitute/openidc-proxy"` | Proxy image repository |
| proxy.image.version | string | `"bernick_tcell"` | Proxy image tag |
| proxy.ldap.baseDomain | string | `nil` | Base domain for LDAP. Required if proxy.ldap.enabled is true |
| proxy.ldap.enabled | bool | `true` | Enables LDAP authorization checks in the proxy |
| proxy.ldap.passwordVaultPath | string | `nil` | Vault path for LDAP binding password. Required if proxy.ldap.enabled is true |
| proxy.ldap.url | string | `nil` | URL of LDAP server to use for auth. Required if proxy.ldap.enabled is true |
| proxy.logLevel | string | `"debug"` | Proxy log level |
| proxy.reloadOnCertUpdate | bool | `true` | Whether to reload the deployment when the cert is updated. Requires stakater/Reloader service to be running in the cluster. |
| proxy.tcell.enabled | bool | `true` | Enables TCell |
| proxy.tcell.hostIdentifier | string | `nil` | Identifier used for logging to TCell. Required if proxy.tcell.enabled is true |
| proxy.tcell.vaultPrefix | string | `nil` | Prefix for TCell secrets in vault. Required if proxy.tcell.enabled is true. |
| replicas | int | `1` |  |
| samAddress | string | `"https://sam.dsde-dev.broadinstitute.org/"` | Address of SAM instance this deploy will talk to |
| samplingProbability | float | `1` | the frequency with which calls should be traced. |
| serviceAllowedAddresses | object | `{}` | A map of addresses in the form `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
| serviceFirewallEnabled | bool | `false` | Whether to restrict access to the service to the IPs supplied via serviceAllowedAddresses |
| serviceGoogleProject | string | `"broad-dsde-dev"` | the id of the google project which the instance is associated with |
| serviceIP | string | `nil` | External IP of the service. Required. |
| spendBillingAccountId | string | `nil` | the Google Billing account Id for WSM to use for workspace projects. |
| spendProfileId | string | `nil` | the Spend Profile Id to associate with the billing account. |
| terraDataRepoUrl | string | `"https://jade.datarepo-dev.broadinstitute.org"` | corresponding data repo instance for the environment |
| vault.enabled | bool | `true` | When enabled, syncs required secrets from Vault |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
| vaultCert.cert.path | string | `nil` | Path to secret containing .crt |
| vaultCert.cert.secretKey | string | `nil` | Key in secret containing .crt |
| vaultCert.chain.path | string | `nil` | Path to secret containing intermediate .crt |
| vaultCert.chain.secretKey | string | `nil` | Key in secret containing intermediate .crt |
| vaultCert.enabled | bool | `false` | Enable to sync certificate secret from Vault with secrets-manager |
| vaultCert.key.path | string | `nil` | Path to secret containing .key |
| vaultCert.key.secretKey | string | `nil` | Key in secret containing .key |
