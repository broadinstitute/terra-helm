workspacemanager
================

Chart for Terra Workspace Manager

## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://broadinstitute.jfrog.io/broadinstitute/terra-helm-proxy | postgres | 0.1.0 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| buffer.clientCredentialPath | string | `nil` | the credentials to use for talking to buffer service. Required if enabled is true. |
| buffer.enabled | bool | `false` | When enabled, use Buffer service to create projects. |
| buffer.instanceUrl | string | `nil` | the Buffer Service instance to use in a given environment. |
| buffer.poolId | string | `nil` | pool in Buffer Service to use. Must include version information and match a poolId in the buffer service config in the environment given above. |
| cloudTraceEnabled | bool | `true` | Whether to enable gcp cloud trace |
| global.applicationVersion | string | `"latest"` | What version of the application to deploy |
| global.terraEnv | string | Is set by Helmfile on deploy | Terget Terra environment name. Required. |
| image | string | Is set by Skaffold on local deploys | Used for local Skaffold deploys |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"gcr.io/terra-kernel-k8s/terra-workspace-manager"` | Image repository |
| imageConfig.tag | string | global.applicationVersion | Image tag. |
| ingress.cert.certManager.duration | string | `"2160h0m0s"` | Certificate duration. Defaults to 3 months. |
| ingress.cert.certManager.enabled | bool | `false` | Enable creating certificate secret with cert-manager |
| ingress.cert.certManager.issuerKind | string | `"ClusterIssuer"` |  |
| ingress.cert.certManager.issuerName | string | `"cert-manager-letsencrypt-prod"` |  |
| ingress.cert.certManager.renewBefore | string | `"720h0m0s"` | When to renew the cert. Defaults to 30 days before expiry. |
| ingress.cert.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.cert.vault.cert.path | string | `nil` | Path to secret containing .crt |
| ingress.cert.vault.cert.secretKey | string | `nil` | Key in secret containing .crt |
| ingress.cert.vault.chain.path | string | `nil` | Path to secret containing intermediate .crt |
| ingress.cert.vault.chain.secretKey | string | `nil` | Key in secret containing intermediate .crt |
| ingress.cert.vault.enabled | bool | `true` | Enable syncing certificate secret from Vault. Requires [secrets-manager](https://github.com/tuenti/secrets-manager) |
| ingress.cert.vault.key.path | string | `nil` | Path to secret containing .key |
| ingress.cert.vault.key.secretKey | string | `nil` | Key in secret containing .key |
| ingress.domain.hostname | string | `"workspace"` |  |
| ingress.domain.namespaceEnv | bool | `true` |  |
| ingress.domain.suffix | string | `"integ.envs.broadinstitute.org"` |  |
| ingress.enabled | bool | `true` | Whether to create Ingress, Service and associated config resources |
| ingress.securityPolicy | string | `""` | (string) Name of a GCP Cloud Armor security policy |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` |  |
| initDB | bool | `false` | Whether the WSM and Stairway DBs should be initialized on startup. Used for preview environments. |
| name | string | `"workspacemanager"` | A name for the deployment that will be substituted into resuorce definitions |
| postgres.dbs | list | `["workspace","stairway"]` | (array(string)) List of databases to create. |
| postgres.enabled | bool | `false` | Whether to enable ephemeral Postgres container. Used for preview/test environments. See the postgres chart for more config options. |
| probes.liveness.enabled | bool | `false` |  |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/version"` |  |
| probes.liveness.spec.httpGet.port | int | `8080` |  |
| probes.liveness.spec.initialDelaySeconds | int | `20` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.successThreshold | int | `1` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `6` |  |
| probes.readiness.spec.httpGet.path | string | `"/status"` |  |
| probes.readiness.spec.httpGet.port | int | `8080` |  |
| probes.readiness.spec.initialDelaySeconds | int | `20` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `5` |  |
| prometheus.enabled | bool | `true` |  |
| prometheus.initContainerImage | string | `"alpine:3.12.0"` |  |
| prometheus.jmxJarRepo | string | `"https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent"` |  |
| prometheus.jmxJarVersion | string | `"0.13.0"` |  |
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
| replicas | int | `0` | Number of replicas for the deployment |
| resources.limits.cpu | int | `1` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"8Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `1` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"8Gi"` | Memory to request for the deployment |
| samAddress | string | `"https://sam.dsde-dev.broadinstitute.org/"` | Address of SAM instance this deploy will talk to |
| samplingProbability | float | `1` | the frequency with which calls should be traced. |
| serviceGoogleProject | string | `"broad-dsde-dev"` | the id of the google project which the instance is associated with |
| spendBillingAccountId | string | `nil` | the Google Billing account Id for WSM to use for workspace projects. |
| spendProfileId | string | `nil` | the Spend Profile Id to associate with the billing account. |
| terraDataRepoUrl | string | `"https://jade.datarepo-dev.broadinstitute.org"` | corresponding data repo instance for the environment |
| vault.enabled | bool | `true` | When enabled, syncs required secrets from Vault |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
