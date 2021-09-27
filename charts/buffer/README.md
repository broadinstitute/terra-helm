# buffer

![Version: 0.30.0](https://img.shields.io/badge/Version-0.30.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Chart for Resource Buffering Service

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>
* <https://github.com/DataBiosphere/terra-resource-buffer>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://broadinstitute.github.io/terra-helm/ | liquibase-migration | 1.0.0-503.1632773568.0fec2e |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| buffer.pool.configPath | string | `nil` | The configuration files pools and resources. Currently all pool configs are inside Java binary under resources/ so the value is a relative path from resource/, for example: config/dev |
| cleanupAfterHandout | bool | `false` | Whether to publish message to Janitor after resource is handed out. |
| global.applicationVersion | string | `"latest"` | What version of the application to deploy |
| global.terraEnv | string | Is set by Helmfile on deploy | Terget Terra environment name. Required. |
| image | string | Is set by Skaffold on local deploys | Used for local Skaffold deploys |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"gcr.io/terra-kernel-k8s/terra-resource-buffer"` | Image repository |
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
| ingress.domain.hostname | string | `"buffer"` |  |
| ingress.domain.namespaceEnv | bool | `true` |  |
| ingress.domain.suffix | string | `"integ.envs.broadinstitute.org"` |  |
| ingress.enabled | bool | `true` | Whether to create Ingress, Service and associated config resources |
| ingress.securityPolicy | string | `nil` | Name of a GCP Cloud Armor security policy |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` |  |
| liquibase-migration.defaults.enabled | bool | `false` |  |
| liquibase-migration.defaults.k8sServiceAccount | string | `"buffer-service-sa"` |  |
| liquibase-migration.defaults.migrationArgsClasspath[0] | string | `"app/libs/*"` |  |
| liquibase-migration.defaults.migrationArgsClasspath[1] | string | `"app/resources/"` |  |
| liquibase-migration.defaults.migrationArgsConfigDriver | string | `"org.postgresql.Driver"` |  |
| liquibase-migration.defaults.migrationArgsConfigUrl | string | `"jdbc:postgresql://127.0.0.1:5432/${DB_NAME}"` |  |
| liquibase-migration.defaults.migrationDatabaseCredentials.existingKubernetesSecret.passwordKey | string | `"password"` |  |
| liquibase-migration.defaults.migrationDatabaseCredentials.existingKubernetesSecret.usernameKey | string | `"username"` |  |
| liquibase-migration.defaults.migrationDatabaseCredentials.existingKubernetesSecret.variableDatabaseKey | string | `"db"` |  |
| liquibase-migration.defaults.migrationImage | string | `"gcr.io/terra-kernel-k8s/terra-resource-buffer"` |  |
| liquibase-migration.defaults.proxyArgsInstances | string | `"$(SQL_INSTANCE_PROJECT):$(SQL_INSTANCE_REGION):$(SQL_INSTANCE_NAME)=tcp:5432"` |  |
| liquibase-migration.defaults.proxyContainerConfig.env[0].name | string | `"SQL_INSTANCE_PROJECT"` |  |
| liquibase-migration.defaults.proxyContainerConfig.env[0].valueFrom.secretKeyRef.key | string | `"project"` |  |
| liquibase-migration.defaults.proxyContainerConfig.env[0].valueFrom.secretKeyRef.name | string | `"buffer-cloudsql-postgres-instance"` |  |
| liquibase-migration.defaults.proxyContainerConfig.env[1].name | string | `"SQL_INSTANCE_REGION"` |  |
| liquibase-migration.defaults.proxyContainerConfig.env[1].valueFrom.secretKeyRef.key | string | `"region"` |  |
| liquibase-migration.defaults.proxyContainerConfig.env[1].valueFrom.secretKeyRef.name | string | `"buffer-cloudsql-postgres-instance"` |  |
| liquibase-migration.defaults.proxyContainerConfig.env[2].name | string | `"SQL_INSTANCE_NAME"` |  |
| liquibase-migration.defaults.proxyContainerConfig.env[2].valueFrom.secretKeyRef.key | string | `"name"` |  |
| liquibase-migration.defaults.proxyContainerConfig.env[2].valueFrom.secretKeyRef.name | string | `"buffer-cloudsql-postgres-instance"` |  |
| liquibase-migration.defaults.proxyCredentialFileMount.mountFilePath | string | `"/secrets/cloudsql/service-account.json"` |  |
| liquibase-migration.defaults.proxyCredentialFileMount.secretName | string | `"buffer-cloudsql-sa"` |  |
| liquibase-migration.enumerated[0].migrationArgsConfigChangelog | string | `"db/changelog.xml"` |  |
| liquibase-migration.enumerated[0].migrationDatabaseCredentials.existingKubernetesSecret.name | string | `"buffer-postgres-db-creds"` |  |
| liquibase-migration.enumerated[0].name | string | `"buffer"` |  |
| liquibase-migration.enumerated[1].migrationArgsConfigChangelog | string | `"stairway/db/changelog.xml"` |  |
| liquibase-migration.enumerated[1].migrationDatabaseCredentials.existingKubernetesSecret.name | string | `"buffer-stairway-db-creds"` |  |
| liquibase-migration.enumerated[1].name | string | `"buffer-stairway"` |  |
| liquibase-migration.name | string | `"buffer"` |  |
| name | string | `"buffer"` | A name for the deployment that will be substituted into resuorce definitions |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/status"` |  |
| probes.liveness.spec.httpGet.port | int | `8080` |  |
| probes.liveness.spec.initialDelaySeconds | int | `15` |  |
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
| probes.startup.enabled | bool | `true` |  |
| probes.startup.spec.failureThreshold | int | `1080` |  |
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
| proxy.whitelist.enabled | bool | `true` | Enables proxy client email whitelisting |
| replicas | int | `0` | Number of replicas for the deployment |
| resources.limits.cpu | string | `"500m"` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"4Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | string | `"500m"` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"4Gi"` | Memory to request for the deployment |
| startupSleep | int | `30` | Allows CloudSQL proxy time to start up. See DDO-1352 |
| vault.enabled | bool | `true` | When enabled, syncs required secrets from Vault |
| vault.janitorClientCredentialPath | string | `nil` | Vault path where Janitor client credential is stored. |
| vault.janitorPubSubConfigPath | string | `nil` | Janitor related configs in Vault path prefix. Required if vault.enabled and cleanupAfterHandout. Now those Janitor configs are generated by Terraform and output to Vault. |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
