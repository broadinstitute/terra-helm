ontology
========
A Helm chart for DUOS Ontology, the DUOS Algorithmic Matching System

Current chart version is `0.7.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| devDeploy | bool | `false` |  |
| elasticSearchServer1 | string | `nil` |  |
| elasticSearchServer2 | string | `nil` |  |
| elasticSearchServer3 | string | `nil` |  |
| environment | string | `nil` |  |
| gcsAccountKey | string | `nil` |  |
| gcsAccountPath | string | `nil` |  |
| global.applicationVersion | string | `"latest"` | What version of the Ontology application to deploy |
| googleBucket | string | `nil` |  |
| googleBucketSubdirectory | string | `nil` |  |
| image | string | `nil` |  |
| imageRepository | string | `nil` |  |
| imageTag | string | `nil` |  |
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
| proxyImageRepository | string | `nil` |  |
| proxyImageVersion | string | `nil` |  |
| proxyLogLevel | string | `nil` |  |
| replicas | int | `1` |  |
| sentryDsnKey | string | `nil` |  |
| sentryDsnPath | string | `nil` |  |
| serviceIP | string | `nil` | External IP of the service. Required. |
| vaultCertPath | string | `nil` |  |
| vaultCertSecretKey | string | `nil` |  |
| vaultChain | string | `nil` |  |
| vaultChainPath | string | `nil` |  |
| vaultChainSecretKey | string | `nil` |  |
| vaultEnabled | bool | `true` |  |
| vaultKeyPath | string | `nil` |  |
| vaultKeySecretKey | string | `nil` |  |
