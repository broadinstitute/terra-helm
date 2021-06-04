duos
====
A Helm chart for DUOS

Current chart version is `0.6.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apiUrl | string | `nil` | The Consent API url |
| metricsApiUrl | string | `nil` | The Consent Metrics API url |
| devDeploy | bool | `false` |  |
| environment | string | `nil` | The environment of the service. Required |
| errorApiKey | string | `nil` | The StackDriver API client id |
| firecloudUrl | string | `nil` | The FireCloud API url |
| gaId | string | `nil` | The Google Analytics ID |
| global.applicationVersion | string | `"latest"` | What version of the DUOS application to deploy |
| googleClientId | string | `nil` | The OAuth google client id |
| gwasUrl | string | `nil` | The GWAS url, currently unused |
| image | string | `nil` |  |
| imageRepository | string | `nil` |  |
| imageTag | string | `nil` |  |
| ingress.cert.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.cert.vault.cert.path | string | `nil` | Path to secret containing .crt |
| ingress.cert.vault.cert.secretKey | string | `nil` | Key in secret containing .crt |
| ingress.cert.vault.enabled | bool | `false` |  |
| ingress.cert.vault.key.path | string | `nil` | Path to secret containing .key |
| ingress.cert.vault.key.secretKey | string | `nil` | Key in secret containing .key |
| ingress.enabled | bool | `true` | Whether to create Ingress, Service and associated config resources |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` |  |
| newChairConsole | bool | `nil` | Feature Flag for the new DAC Chair Console |
| newDarUi | bool | `nil` | Feature Flag for the new DAR UI |
| nihUrl | string | `nil` | The eRA Auth Redirect URL |
| ontologyApiUrl | string | `nil` | The Ontology API url |
| powerBiUrl | string | `nil` | The PowerBI url |
| probes.liveness.enabled | bool | `false` |  |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/status"` |  |
| probes.liveness.spec.httpGet.port | int | `8080` |  |
| probes.liveness.spec.initialDelaySeconds | int | `60` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `6` |  |
| probes.readiness.spec.httpGet.path | string | `"/status"` |  |
| probes.readiness.spec.httpGet.port | int | `8080` |  |
| probes.readiness.spec.initialDelaySeconds | int | `60` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `1` |  |
| profileUrl | string | `nil` | The eRA Auth Profile URL |
| proxyImageRepository | string | `nil` |  |
| proxyImageVersion | string | `nil` |  |
| proxyLogLevel | string | `nil` |  |
| replicas | string | `nil` |  |
| vaultCertPath | string | `nil` |  |
| vaultCertSecretKey | string | `nil` |  |
| vaultChain | string | `nil` |  |
| vaultChainPath | string | `nil` |  |
| vaultChainSecretKey | string | `nil` |  |
| vaultEnabled | bool | `true` |  |
| vaultKeyPath | string | `nil` |  |
| vaultKeySecretKey | string | `nil` |  |
