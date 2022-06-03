# calhoun

A Helm chart for Calhoun, Terra's Jupyter notebook preview service

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| calhoun.samRoot | string | `nil` |  |
| calhoun.swaggerClientId | string | `nil` |  |
| calhoun.swaggerRealm | string | `nil` |  |
| global.applicationVersion | string | `"latest"` | What version of the application to deploy |
| global.terraEnv | string | Is set by Helmfile on deploy | Terget Terra environment name. Required. |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"gcr.io/broad-dsp-gcr-public/calhoun"` | Image repository |
| imageConfig.tag | string | global.applicationVersion | Image tag. |
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
| ingress.domain.hostname | string | `"calhoun"` |  |
| ingress.domain.namespaceEnv | bool | `true` |  |
| ingress.domain.suffix | string | `"dsde-dev.broadinstitute.org"` |  |
| ingress.enabled | bool | `true` | Whether to create Ingress, Service and associated config resources |
| ingress.securityPolicy | string | `nil` | Name of a GCP Cloud Armor security policy |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` |  |
| name | string | `"calhoun"` | A name for the deployment that will be substituted into resource definitions |
| probes.liveness.enabled | bool | `true` | Whether to configure a liveness probe |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/status"` |  |
| probes.liveness.spec.httpGet.port | int | `8080` |  |
| probes.liveness.spec.initialDelaySeconds | int | `15` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.successThreshold | int | `1` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` | Whether to configure a readiness probe |
| probes.readiness.spec.failureThreshold | int | `6` |  |
| probes.readiness.spec.httpGet.path | string | `"/status"` |  |
| probes.readiness.spec.httpGet.port | int | `8080` |  |
| probes.readiness.spec.initialDelaySeconds | int | `20` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `5` |  |
| probes.startup.enabled | bool | `true` | Whether to configure a startup probe |
| probes.startup.spec.failureThreshold | int | `6` |  |
| probes.startup.spec.httpGet.path | string | `"/status"` |  |
| probes.startup.spec.httpGet.port | int | `8080` |  |
| probes.startup.spec.periodSeconds | int | `10` |  |
| probes.startup.spec.successThreshold | int | `1` |  |
| probes.startup.spec.timeoutSeconds | int | `5` |  |
| proxy.enabled | bool | `true` |  |
| proxy.image.repository | string | `"broadinstitute/openidc-proxy"` | Proxy image repository |
| proxy.image.version | string | `"tcell_3_1_0"` | Proxy image tag |
| proxy.logLevel | string | `"debug"` | Proxy log level |
| proxy.reloadOnCertUpdate | bool | `false` | Whether to reload the deployment when the cert is updated. Requires stakater/Reloader service to be running in the cluster. |
| proxy.tcell.enabled | bool | `true` | Enables TCell |
| proxy.tcell.hostIdentifier | string | `nil` | Identifier used for logging to TCell. Required if proxy.tcell.enabled is true |
| proxy.tcell.vaultPrefix | string | `nil` | Prefix for TCell secrets in vault. Required if proxy.tcell.enabled is true. |
| proxy.whitelist.email | string | `nil` | Required if whitelisting is enabled. Email of buffer client Google service account |
| proxy.whitelist.enabled | bool | `false` | Enables proxy client email whitelisting |
| replicas | int | `3` | Number of replicas for the deployment |
| resources.limits.cpu | int | `2` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"4Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `2` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"4Gi"` | Memory to request for the deployment |
| vault.enabled | bool | `true` | When enabled, syncs required secrets from Vault |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
