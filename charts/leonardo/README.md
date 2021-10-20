# leonardo

A Helm chart for Leonardo, a Terra service for interactive analysis applications

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://broadinstitute.github.io/terra-helm/ | ingresslib | 0.12.0 |
| https://broadinstitute.github.io/terra-helm/ | pdb-lib | 0.4.0 |
| https://terra-helm.storage.googleapis.com/ | liquibase-migration | 1.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| commonCronjob.reportDestinationBucket | string | `nil` |  |
| cronjob.enabled | bool | `false` |  |
| cronjob.googleProject | string | `nil` |  |
| cronjob.imageRepository | string | `"us.gcr.io/broad-dsp-gcr-public/resource-validator"` |  |
| cronjob.imageTag | string | `"79854b1"` |  |
| cronjob.name | string | `"leonardo-resource-validator-cronjob"` |  |
| deploymentDefaults.annotations | object | `{}` |  |
| deploymentDefaults.enabled | bool | `true` | Whether a declared deployment is enabled. If false, no resources will be created |
| deploymentDefaults.imageRepository | string | `"gcr.io/broad-dsp-gcr-public/leonardo"` | Image repo to pull Leonardo images from |
| deploymentDefaults.imageTag | string | `nil` | Image tag to be used when deploying Pods @default global.applicationVersion |
| deploymentDefaults.name | Required | `nil` | A name for the deployment that will be substituted into resource definitions. Example: `"leonardo-backend"`. The deployment name will be substituted into Deployment and ConfigMap names.   Eg. "leonardo-frontend" -> "leonardo-frontend-deployment", "leonardo-frontend-cm" |
| deploymentDefaults.probes.liveness.enabled | bool | `true` |  |
| deploymentDefaults.probes.liveness.spec | object | `{"failureThreshold":30,"httpGet":{"path":"/version","port":8080},"initialDelaySeconds":15,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the liveness probe to deploy, if enabled |
| deploymentDefaults.probes.readiness.enabled | bool | `true` |  |
| deploymentDefaults.probes.readiness.spec | object | `{"failureThreshold":6,"httpGet":{"path":"/status","port":8080},"initialDelaySeconds":15,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the readiness probe to deploy, if enabled |
| deploymentDefaults.probes.startup.enabled | bool | `true` |  |
| deploymentDefaults.probes.startup.spec | object | `{"failureThreshold":1080,"httpGet":{"path":"/version","port":8080},"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the startup probe to deploy, if enabled |
| deploymentDefaults.proxyImage | string | `"broadinstitute/openidc-proxy:tcell_3_1_0"` | Image that the OIDC proxy uses |
| deploymentDefaults.replicas | int | `0` | Number of replicas for the deployment |
| deploymentDefaults.startupSleep | int | `30` |  |
| deployments.standalone.name | string | `"leonardo"` | Name to use for the default standalone Leonardo deployment |
| deployments.standalone.replicas | int | `1` | Number of replicas in the default standalone Leonardo deployment |
| global.applicationVersion | string | `"latest"` | What version of the Leonardo application to deploy |
| ingress.deployment | string | `"leonardo"` | Name of the deployment to associate with the Ingress (should correspond to the "name" field of a deployment, under the deployments key, above) |
| ingress.enabled | bool | `true` | Whether to create Ingress, Service and associated config resources |
| ingress.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.requestPath | string | `"/status"` |  |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `28800` | Load balancer backend timeout (Leonardo has a large backend timeout to support long-lived websockets -- see DDO-132 / IA-1665) |
| janitorCron.enabled | bool | `false` |  |
| janitorCron.imageRepository | string | `"us.gcr.io/broad-dsp-gcr-public/janitor"` |  |
| janitorCron.imageTag | string | `"79854b1"` |  |
| janitorCron.name | string | `"leonardo-janitor-cronjob"` |  |
| liquibase-migration.defaults.enabled | bool | `false` |  |
| liquibase-migration.defaults.migrationArgsClasspath[0] | string | `"$(find /leonardo -name 'leonardo*.jar')"` |  |
| liquibase-migration.defaults.migrationConfigFileMount.secretName | string | `"leonardo-backend-app-ctmpls"` |  |
| liquibase-migration.defaults.migrationDatabaseCredentials.fromVaultSecret.passwordKey | string | `"db_password"` |  |
| liquibase-migration.defaults.migrationDatabaseCredentials.fromVaultSecret.path | string | `nil` |  |
| liquibase-migration.defaults.migrationDatabaseCredentials.fromVaultSecret.usernameKey | string | `"db_user"` |  |
| liquibase-migration.defaults.migrationImage | string | `"gcr.io/broad-dsp-gcr-public/leonardo"` |  |
| liquibase-migration.defaults.sqlproxyContainerConfig.envFrom[0].secretRef.name | string | `"leonardo-backend-sqlproxy-env"` |  |
| liquibase-migration.defaults.sqlproxyCredentialFileMount.secretName | string | `"leonardo-backend-sqlproxy-ctmpls"` |  |
| monitoring.enabled | bool | `true` | Whether to enable Prometheus monitoring for Leonardo pods |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
| zombieMonitorCron.enabled | bool | `false` |  |
| zombieMonitorCron.imageRepository | string | `"us.gcr.io/broad-dsp-gcr-public/zombie-monitor"` |  |
| zombieMonitorCron.imageTag | string | `"79854b1"` |  |
| zombieMonitorCron.name | string | `"leonardo-zombie-monitor-cronjob"` |  |
