# cromwell

A Helm chart for Cromwell, the Terra Workflow Management System

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://terra-helm.storage.googleapis.com | liquibase-migration-cromwell1(liquibase-migration) | 1.1.0-584.1634935238.b378e3 |
| https://terra-helm.storage.googleapis.com | liquibase-migration-cromwell2(liquibase-migration) | 1.1.0-584.1634935238.b378e3 |

# Databases and Migrations

Note that this chart makes fairly advanced usage of the liquibase-migration chart to perform
preflight migrations in Argo CD. While a normal chart would pull in the chart, set some defaults,
and leave it to env-specific values files to point it at one or more specific databases, Cromwell's
usage is more complex.

In some Cromwell deployments--that is, installations of this chart--there are two "logical systems"
for Cromwell (effectively two instances of the app). Each logical system has its own configuration,
secrets, and database, but they share the same K8s RBAC resources. These logical systems are usually
called "cromwell1" and "cromwell2", but from some vantage points they are seen as "reader" and
"legacy" respectively.

Within each logical system, Cromwell runs two migrations in parallel: one for its internal engine
service and one for its internal metadata service. *These migrations target the same database*.
The engine migration is a standard migration targeting a `changelog.xml`, but the metadata
migration is non-standard: beyond targeting a `sql_metadata_changelog.xml`, it uses custom
names for the changelog and changelog lock tables, allowing it to run in parallel with the
engine migration.

> This removes a major guardrail from Liquibase, in that the two migrations will invalidate each
> other if the changelogs themselves happen to overlap at any point. This is a developer decision,
> though, and Cromwell itself does these migrations in parallel--DevOps's addition of migrations
> in Kubernetes does not add new behavior.

Two configure these migrations to happen preflight (before Cromwell starts) on Kubernetes, we
actually pull in the liquibase-migration subchart twice, via an alias: once for each logical
system. Each logical system then has its own defaults (pointing at that system's secrets and
configuration) and its own set of two migrations (one for the engine and one for the metadata).
This results in a total of four migrations. See the values file itself for information enabling/
configuring the migrations.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| deploymentDefaults.annotations | object | `{}` |  |
| deploymentDefaults.enabled | bool | `true` | Whether a declared deployment is enabled. If false, no resources will be created |
| deploymentDefaults.expose | bool | `false` | Whether to create a Service for this deployment |
| deploymentDefaults.imageTag | string | `nil` | Image tag to be used when deploying Pods @defautl global.applicationVersion |
| deploymentDefaults.legacyResourcePrefix | string | `nil` | What prefix to use to refer to secrets rendered from firecloud-develop @default deploymentDefaults.name |
| deploymentDefaults.name | string | `nil` | A name for the deployment that will be substituted into resource definitions. Example: `"cromwell1-reader"` |
| deploymentDefaults.nodeSelector | object | `nil` | Optional nodeSelector map |
| deploymentDefaults.probes.liveness.enabled | bool | `true` | Whether to configure a liveness probe |
| deploymentDefaults.probes.liveness.spec | object | `{"failureThreshold":30,"httpGet":{"path":"/engine/latest/version","port":8000},"initialDelaySeconds":20,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the liveness probe to deploy, if enabled |
| deploymentDefaults.probes.readiness.enabled | bool | `true` | Whether to configure a readiness probe |
| deploymentDefaults.probes.readiness.spec | object | `{"failureThreshold":6,"httpGet":{"path":"/engine/latest/version","port":8000},"initialDelaySeconds":20,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the readiness probe to deploy, if enabled |
| deploymentDefaults.probes.startup.enabled | bool | `true` | Whether to configure a startup probe |
| deploymentDefaults.probes.startup.spec | object | `{"failureThreshold":1080,"httpGet":{"path":"/engine/latest/version","port":8000},"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the startup probe to deploy, if enabled |
| deploymentDefaults.proxyImage | string | `"broadinstitute/openidc-proxy:tcell_3_1_0"` |  |
| deploymentDefaults.replicas | int | `0` | Number of replicas for the deployment |
| deploymentDefaults.serviceAllowedAddresses | object | `{}` | What source IPs to whitelist for access to the service |
| deploymentDefaults.serviceIP | string | `nil` | Static IP to use for the Service. If set, service will be of type LoadBalancer |
| deploymentDefaults.serviceName | string | `nil` | What to call the Service |
| deploymentDefaults.tolerations | array | `nil` | Optional array of tolerations |
| deployments.standalone.expose | bool | `true` | Whether to expose the default standalone Cromwell deployment as a service |
| deployments.standalone.name | string | `"cromwell"` | Name to use for the default standalone Cromwell deployment |
| deployments.standalone.replicas | int | `1` | Number of replicas in the default standalone Cromwell deployment |
| deployments.standalone.serviceName | string | `"cromwell"` | Name of the default standalone Cromwell service |
| global.applicationVersion | string | `"latest"` | What version of the Cromwell application to deploy |
| global.trustedAddresses | object | `{}` | A map of addresses that will be merged with serviceAllowedAddresses. Example: `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
| liquibase-migration-cromwell1.defaults.enabled | bool | `false` |  |
| liquibase-migration-cromwell1.defaults.migrationArgsClasspath[0] | string | `"/app/cromwell.jar"` |  |
| liquibase-migration-cromwell1.defaults.migrationConfigFileMount.secretName | string | `"cromwell1-frontend-app-ctmpls"` |  |
| liquibase-migration-cromwell1.defaults.migrationDatabaseCredentials.fromVaultSecret.passwordKey | string | `"db_password"` |  |
| liquibase-migration-cromwell1.defaults.migrationDatabaseCredentials.fromVaultSecret.path | string | `nil` |  |
| liquibase-migration-cromwell1.defaults.migrationDatabaseCredentials.fromVaultSecret.usernameKey | string | `"db_user"` |  |
| liquibase-migration-cromwell1.defaults.migrationImage | string | `"broadinstitute/cromwell"` |  |
| liquibase-migration-cromwell1.defaults.sqlproxyContainerConfig.envFrom[0].secretRef.name | string | `"cromwell1-frontend-sqlproxy-env"` |  |
| liquibase-migration-cromwell1.defaults.sqlproxyCredentialFileMount.secretName | string | `"cromwell1-frontend-sqlproxy-ctmpls"` |  |
| liquibase-migration-cromwell1.migrationJobs[0].migrationArgsAdditional | string | `"--databaseChangeLogTableName=DATABASECHANGELOG \\\n--databaseChangeLogLockTableName=DATABASECHANGELOGLOCK"` |  |
| liquibase-migration-cromwell1.migrationJobs[0].migrationArgsConfigChangelog | string | `"changelog.xml"` |  |
| liquibase-migration-cromwell1.migrationJobs[0].name | string | `"cromwell1-engine"` |  |
| liquibase-migration-cromwell1.migrationJobs[1].migrationArgsAdditional | string | `"--databaseChangeLogTableName=SQLMETADATADATABASECHANGELOG \\\n--databaseChangeLogLockTableName=SQLMETADATADATABASECHANGELOGLOCK"` |  |
| liquibase-migration-cromwell1.migrationJobs[1].migrationArgsConfigChangelog | string | `"sql_metadata_changelog.xml"` |  |
| liquibase-migration-cromwell1.migrationJobs[1].name | string | `"cromwell1-metadata"` |  |
| liquibase-migration-cromwell2.defaults.enabled | bool | `false` |  |
| liquibase-migration-cromwell2.defaults.migrationArgsClasspath[0] | string | `"/app/cromwell.jar"` |  |
| liquibase-migration-cromwell2.defaults.migrationConfigFileMount.secretName | string | `"cromwell2-app-ctmpls"` |  |
| liquibase-migration-cromwell2.defaults.migrationDatabaseCredentials.fromVaultSecret.passwordKey | string | `"db_password"` |  |
| liquibase-migration-cromwell2.defaults.migrationDatabaseCredentials.fromVaultSecret.path | string | `nil` |  |
| liquibase-migration-cromwell2.defaults.migrationDatabaseCredentials.fromVaultSecret.usernameKey | string | `"db_user"` |  |
| liquibase-migration-cromwell2.defaults.migrationImage | string | `"broadinstitute/cromwell"` |  |
| liquibase-migration-cromwell2.defaults.sqlproxyContainerConfig.envFrom[0].secretRef.name | string | `"cromwell2-sqlproxy-env"` |  |
| liquibase-migration-cromwell2.defaults.sqlproxyCredentialFileMount.secretName | string | `"cromwell2-sqlproxy-ctmpls"` |  |
| liquibase-migration-cromwell2.migrationJobs[0].migrationArgsAdditional | string | `"--databaseChangeLogTableName=DATABASECHANGELOG \\\n--databaseChangeLogLockTableName=DATABASECHANGELOGLOCK"` |  |
| liquibase-migration-cromwell2.migrationJobs[0].migrationArgsConfigChangelog | string | `"changelog.xml"` |  |
| liquibase-migration-cromwell2.migrationJobs[0].name | string | `"cromwell2-engine"` |  |
| liquibase-migration-cromwell2.migrationJobs[1].migrationArgsAdditional | string | `"--databaseChangeLogTableName=SQLMETADATADATABASECHANGELOG \\\n--databaseChangeLogLockTableName=SQLMETADATADATABASECHANGELOGLOCK"` |  |
| liquibase-migration-cromwell2.migrationJobs[1].migrationArgsConfigChangelog | string | `"sql_metadata_changelog.xml"` |  |
| liquibase-migration-cromwell2.migrationJobs[1].name | string | `"cromwell2-metadata"` |  |
