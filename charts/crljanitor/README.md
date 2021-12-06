# crljanitor

![Version: 0.9.0](https://img.shields.io/badge/Version-0.9.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Chart for Cloud Resource Manager Janitor

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>
* <https://github.com/DataBiosphere/terra-resource-janitor>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://terra-helm.storage.googleapis.com | sherlock-reporter | 0.3.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| azureManagedApp.enabled | bool | `false` | Enables Janitor to process resources in an Azure managed app. |
| azureManagedApp.vaultPath | string | `"secret/dsde/terra/azure/common/managed-app-publisher"` | (string) Vault path for Azure managed app publisher credentials. Uses the same path for all envs by default. Override if needed in helmfile repo. |
| certManager.duration | string | `"2160h0m0s"` | Certificate duration. Defaults to 3 months. |
| certManager.enabled | bool | `false` | Enable to create certificate secret with cert-manager |
| certManager.issuerKind | string | `"ClusterIssuer"` |  |
| certManager.issuerName | string | `"cert-manager-letsencrypt-prod"` |  |
| certManager.renewBefore | string | `"720h0m0s"` | When to renew the cert. Defaults to 30 days before expiry. |
| configBasedAuthzEnabled | bool | `true` | Whether to use static file with admin users email for authorization. TODO(PF-81): Switch to use SAM instead of config file for user authZ. |
| domain.hostname | string | `"crljanitor"` | Hostname of this deployment |
| domain.namespaceEnv | bool | `true` | If true, an extra level of namespacing (`global.terraEnv`) will be added between the hostname and suffix |
| domain.suffix | string | `"integ.envs.broadinstitute.org"` | Domain suffix |
| global.applicationVersion | string | Is set by Helmfile on deploy | Service image version/tag. Required unless using `image`. |
| global.terraEnv | string | Is set by Helmfile on deploy | Terget Terra environment name. Required. |
| global.trustedAddresses | object | `{}` | A map of addresses that will be merged with serviceAllowedAddresses. Example: `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
| image | string | Is set by Skaffold on local deploys | Used for local Skaffold deploys |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"gcr.io/terra-kernel-k8s/terra-resource-janitor"` | Image repository |
| imageConfig.tag | string | The chart's appVersion value will be used | Image tag. |
| proxy.enabled | bool | `true` |  |
| proxy.image.repository | string | `"broadinstitute/openidc-proxy"` | Proxy image repository |
| proxy.image.version | string | `"bernick_tcell"` | Proxy image tag |
| proxy.logLevel | string | `"debug"` | Proxy log level |
| replicas | int | `1` |  |
| serviceAllowedAddresses | object | `{}` | A map of addresses in the form `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
| serviceFirewallEnabled | bool | `false` | Whether to restrict access to the service to the IPs supplied via serviceAllowedAddresses |
| serviceIP | string | `nil` | External IP of the service. Required. |
| sherlock.appImageName | string | `"gcr.io/terra-kernel-k8s/terra-resource-janitor"` |  |
| sherlock.appName | string | `"crljanitor"` |  |
| sherlock.enabled | bool | `true` |  |
| sherlock.serviceAccount | string | `"terra-crl-janitor-service-sa"` |  |
| sherlock.sherlockImageTag | string | `"v0.0.15"` |  |
| sherlock.vault.pathPrefix | string | `"secret/suitable/sherlock/prod"` |  |
| startupSleep | int | `30` | Allows CloudSQL proxy time to start up. See DDO-1352 |
| trackResourcePubsubEnabled | bool | `true` | Whether to enable using pubsub to receive new tracked resources. |
| vault.adminUserFilePath | string | `"config/terra/crl-janitor/common/iam"` | (string) Vault path prefix for admin user list. Required if vault.enabled. Use the same users as admin for all env by default. Override if needed in helmfile repo. |
| vault.configPathPrefix | string | `nil` | Vault path prefix for configs. Required if vault.enabled. |
| vault.enabled | bool | `true` | When enabled, syncs required secrets from Vault |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
| vaultCert.cert.path | string | `nil` | Path to secret containing .crt |
| vaultCert.cert.secretKey | string | `nil` | Key in secret containing .crt |
| vaultCert.chain.path | string | `nil` | Path to secret containing intermediate .crt |
| vaultCert.chain.secretKey | string | `nil` | Key in secret containing intermediate .crt |
| vaultCert.enabled | bool | `false` | Enable to sync certificate secret from Vault with secrets-manager |
| vaultCert.key.path | string | `nil` | Path to secret containing .key |
| vaultCert.key.secretKey | string | `nil` | Key in secret containing .key |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
