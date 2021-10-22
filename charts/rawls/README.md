# rawls

![Version: 0.22.0](https://img.shields.io/badge/Version-0.22.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

Chart for Rawls service in Terra

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>
* <https://github.com/broadinstitute/rawls>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://broadinstitute.github.io/terra-helm/ | pdb-lib | 0.4.0 |
| https://terra-helm.storage.googleapis.com | liquibase-migration | 1.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| deploymentDefaults.annotations | object | `{}` |  |
| deploymentDefaults.buffer.enabled | bool | `true` |  |
| deploymentDefaults.enabled | bool | `true` | Whether a declared deployment is enabled. If false, no resources will be created |
| deploymentDefaults.expose | bool | `false` | Whether to create a Service for this deployment |
| deploymentDefaults.imageTag | string | `nil` | Image tag to be used when deploying Pods @default global.applicationVersion |
| deploymentDefaults.legacyResourcePrefix | string | `nil` | What prefix to use to refer to secrets rendered from firecloud-develop @default deploymentDefaults.name |
| deploymentDefaults.name | string | `nil` | A name for the deployment that will be substituted into resource definitions. Example: `"rawls1-reader"` |
| deploymentDefaults.probes.liveness.enabled | bool | `true` |  |
| deploymentDefaults.probes.liveness.spec | object | `{"failureThreshold":30,"httpGet":{"path":"/status","port":8080},"initialDelaySeconds":20,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the liveness probe to deploy, if enabled |
| deploymentDefaults.probes.readiness.enabled | bool | `true` |  |
| deploymentDefaults.probes.readiness.spec | object | `{"failureThreshold":6,"httpGet":{"path":"/status","port":8080},"initialDelaySeconds":20,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the readiness probe to deploy, if enabled |
| deploymentDefaults.probes.startup.enabled | bool | `true` |  |
| deploymentDefaults.probes.startup.spec.failureThreshold | int | `1080` |  |
| deploymentDefaults.probes.startup.spec.httpGet.path | string | `"/status"` |  |
| deploymentDefaults.probes.startup.spec.httpGet.port | int | `8080` |  |
| deploymentDefaults.probes.startup.spec.periodSeconds | int | `10` |  |
| deploymentDefaults.probes.startup.spec.successThreshold | int | `1` |  |
| deploymentDefaults.probes.startup.spec.timeoutSeconds | int | `5` |  |
| deploymentDefaults.proxyImage | string | `"broadinstitute/openidc-proxy:tcell_3_1_0"` | Image that the OIDC proxy uses |
| deploymentDefaults.replicas | int | `0` | Number of replicas for the deployment |
| deploymentDefaults.serviceIP | string | `nil` | Static IP to use for the Service. If set, service will be of type LoadBalancer |
| deploymentDefaults.serviceName | string | `nil` | What to call the Service |
| global.applicationVersion | string | `"latest"` | What version of the rawls application to deploy |
| ingress.preSharedCerts | list | `[]` | (string) List of pre existing gcp certs to use on ingress |
| ingress.serviceName | string | `"rawls-frontend"` | (string) Name of the rawls service to associate with GKE ingress. |
| ingress.sslPolicy | string | `"tls12-ssl-policy"` | (string) Name of an existing google ssl policy to associate with an ingress frontend-config |
| ingress.staticIpName | string | `nil` | Required. GCP resource name for ingress static ip |
| ingress.timeoutSec | int | `120` | Number of seconds to timeout on requests to the ingress |
| liquibase-migration.defaults.enabled | bool | `false` |  |
| liquibase-migration.defaults.migrationArgsClasspath[0] | string | `"$(find /rawls -name 'rawls*.jar')"` |  |
| liquibase-migration.defaults.migrationConfigFileMount.secretName | string | `"rawls-backend-app-ctmpls"` |  |
| liquibase-migration.defaults.migrationDatabaseCredentials.fromVaultSecret.passwordKey | string | `"slick_db_password"` |  |
| liquibase-migration.defaults.migrationDatabaseCredentials.fromVaultSecret.path | string | `nil` |  |
| liquibase-migration.defaults.migrationDatabaseCredentials.fromVaultSecret.usernameKey | string | `"slick_db_user"` |  |
| liquibase-migration.defaults.migrationImage | string | `"gcr.io/broad-dsp-gcr-public/rawls"` |  |
| liquibase-migration.defaults.sqlproxyContainerConfig.envFrom[0].secretRef.name | string | `"rawls-backend-sqlproxy-env"` |  |
| liquibase-migration.defaults.sqlproxyCredentialFileMount.secretName | string | `"rawls-backend-sqlproxy-ctmpls"` |  |
| resources.limits.cpu | int | `8` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"16Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `8` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"16Gi"` | Memory to request for the deployment |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
