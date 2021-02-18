consent
=======
A Helm chart for DUOS Consent

Current chart version is `0.8.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| basicAuthPasswordKey | string | `nil` |  |
| basicAuthUserKey | string | `nil` |  |
| cloudSqlInstance | string | `nil` |  |
| confFilePath | string | `nil` |  |
| databasePasswordKey | string | `nil` |  |
| databaseUrl | string | `nil` |  |
| databaseUserKey | string | `nil` |  |
| databaseUserPath | string | `nil` |  |
| devDeploy | bool | `false` |  |
| elasticSearchServer1 | string | `nil` |  |
| elasticSearchServer2 | string | `nil` |  |
| elasticSearchServer3 | string | `nil` |  |
| emailNotificationsEnabled | string | `nil` |  |
| environment | string | `nil` |  |
| gcsAccountKey | string | `nil` |  |
| gcsAccountPath | string | `nil` |  |
| global.applicationVersion | string | `"latest"` | What version of the Ontology application to deploy |
| googleBucket | string | `nil` |  |
| googleBucketSubdirectory | string | `nil` |  |
| googleClientId | string | `nil` |  |
| googleProject | string | `nil` |  |
| googleProjectZone | string | `nil` |  |
| image | string | `nil` |  |
| imageRepository | string | `nil` |  |
| imageTag | string | `nil` |  |
| ingressCert.cert.path | string | `nil` | Path to secret containing .crt |
| ingressCert.cert.secretKey | string | `nil` | Key in secret containing .crt |
| ingressCert.key.path | string | `nil` | Path to secret containing .key |
| ingressCert.key.secretKey | string | `nil` | Key in secret containing .key |
| ingressIpName | string | `nil` |  |
| ingressTimeout | int | `120` | (number) number of seconds requests on the https loadbalancer will time out after |
| probes.liveness.enabled | bool | `false` |  |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/status"` |  |
| probes.liveness.spec.httpGet.port | int | `8080` |  |
| probes.liveness.spec.initialDelaySeconds | int | `60` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `10` |  |
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
| sendgridApiKey | string | `nil` |  |
| sendgridApiKeyKey | string | `nil` |  |
| sentryDsnKey | string | `nil` |  |
| sentryDsnPath | string | `nil` |  |
| servicesLocalUrl | string | `nil` |  |
| servicesOntologyUrl | string | `nil` |  |
| sslPolicy | string | `"tls12-ssl-policy"` |  |
| vaultCertPath | string | `nil` |  |
| vaultCertSecretKey | string | `nil` |  |
| vaultChain | string | `nil` |  |
| vaultChainPath | string | `nil` |  |
| vaultChainSecretKey | string | `nil` |  |
| vaultEnabled | bool | `true` |  |
| vaultKeyPath | string | `nil` |  |
| vaultKeySecretKey | string | `nil` |  |
