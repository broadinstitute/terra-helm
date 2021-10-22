# liquibase-migration

![Version: 1.1.0](https://img.shields.io/badge/Version-1.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Chart to run Liquibase migrations before Terra app startup

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>

helm-docs can't parse all the comments in the values file, [see it for more detail](./values.yaml).

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| defaults | object | See sub-keys | Baseline config merged under each migrationJobs one to form the full configuration for that particular migration |
| defaults.enabled | bool | `false` | Whether to enable migrations by default |
| defaults.k8sAppName | string | `nil` | Name of the application being deployed |
| defaults.k8sLabelRef | string | `nil` | Template reference to use to obtain resource labels, set to empty to disable |
| defaults.k8sServiceAccount | string | `nil` | App's Kubernetes service account (selective sync may be necessary if the KSA isn't applied before k8sSyncWave) |
| defaults.k8sSyncWave | string | `"-1"` | (string) Argo CD wave to apply resources in |
| defaults.migrationArgsAdditional | string | `nil` | Optional arbitrary additional arguments to be passed, from https://docs.liquibase.com/commands/home.html |
| defaults.migrationArgsClasspath | list | `nil` | Java classpath location(s) containing Liquibase, JDBC driver, any packaged changelogs, and all dependencies; if the app is packaged then its `.jar` is sufficient (CLI argument wrapped in double quotes, bash expansion allowed) |
| defaults.migrationArgsConfigChangelog | string | `nil` | Java classpath location of the Liquibase changelog file, expanded by migrationShell |
| defaults.migrationArgsConfigDriver | string | `nil` | Java class name of the JDBC driver to use, expanded by migrationShell |
| defaults.migrationArgsConfigUrl | string | `nil` | JDBC URL of the database, expanded by migrationShell |
| defaults.migrationArgsLiquibaseCommand | string | `"update"` | If the Kubernetes job should always succeed regardless of the Liquibase command's exit status |
| defaults.migrationConfigFileMount | object | With the secret name omitted, no configuration file will be mounted or passed | Controls for mounting and passing a Liquibase.properties file (necessary unless all other migrationConfigArgs* values passed) |
| defaults.migrationConfigFileMount.mountFilePath | string | `"/etc/liquibase.properties"` | The full mount path of the file, ending with the file itself |
| defaults.migrationConfigFileMount.secretName | string | `nil` | The exact name of a Kubernetes secret containing the desired file under a file-named key |
| defaults.migrationDatabaseCredentials | object | None | Controls for setting up database authentication, one sub-object must be provided; fromKubernetesSecret takes precedence if provided |
| defaults.migrationDatabaseCredentials.fromKubernetesSecret | object | With the secret name omitted, no existing Kubernetes secret will be accessed | Use an existing Kubernetes secret for credentials directly |
| defaults.migrationDatabaseCredentials.fromKubernetesSecret.databaseNameKey | string | `nil` | Optional key of a database name in the Kubernetes secret, available as $DB_NAME in the migration container |
| defaults.migrationDatabaseCredentials.fromKubernetesSecret.name | string | `nil` | Name of the existing Kubernetes secret to use |
| defaults.migrationDatabaseCredentials.fromKubernetesSecret.passwordKey | string | `nil` | Key of the password within the Kubernetes secret |
| defaults.migrationDatabaseCredentials.fromKubernetesSecret.usernameKey | string | `nil` | Key of the username within the Kubernetes secret |
| defaults.migrationDatabaseCredentials.fromVaultSecret | object | With the Vault secret path omitted, no Vault secret will be accessed | Create a Kubernetes secret via secrets-manager from a Vault secret |
| defaults.migrationDatabaseCredentials.fromVaultSecret.databaseNameKey | string | `nil` | Optional key of a database name in the Vault secret, available as $DB_NAME in the migration container |
| defaults.migrationDatabaseCredentials.fromVaultSecret.passwordKey | string | `nil` | Key of the password within the Vault secret |
| defaults.migrationDatabaseCredentials.fromVaultSecret.path | string | `nil` | Path of the existing Vault secret to use |
| defaults.migrationDatabaseCredentials.fromVaultSecret.usernameKey | string | `nil` | Key of the username within the Vault secret |
| defaults.migrationDelay | string | `"15s"` | Time to wait before attempting to start Liquibase, to allow proxy to boot |
| defaults.migrationImage | string | `nil` | Image to use for the migration, usually the application image with bundled Liquibase |
| defaults.migrationImageTag | string | `nil` | Image tag to use for the migration image; **warning** that setting this can cause inconsistent migrations (default recommended) |
| defaults.migrationShell | list | `["bash","-c"]` | Docker command directive to invoke a shell in the container, to expand migrationArgs* values |
| defaults.sqlproxyArgsInstances | string | Mimics behavior of legacy broadinstitute/cloudsqlproxy image | Instances argument passed to the proxy executable, expanded by proxyShell |
| defaults.sqlproxyArgsMaxConnections | string | Mimics behavior of legacy broadinstitute/cloudsqlproxy image | Max connections argument passed to the proxy executable, expanded by proxyShell |
| defaults.sqlproxyContainerConfig | object | `nil` | Extra configuration applied directly to the proxy container (useful for env or envFrom directives) |
| defaults.sqlproxyCredentialFileMount | object | With the secret name omitted, no credentials file will be mounted or passed | Controls for mounting and passing a credentials file (necessary unless Workload Identity or another mechanism configured) |
| defaults.sqlproxyCredentialFileMount.mountFilePath | string | `"/etc/sqlproxy-service-account.json"` | The full mount path of the file, ending with the file itself |
| defaults.sqlproxyCredentialFileMount.secretName | string | `nil` | The exact name of a Kubernetes secret containing the desired file under a file-named key |
| defaults.sqlproxyImage | string | `"gcr.io/cloudsql-docker/gce-proxy"` | Image to use for the Cloud SQL Proxy |
| defaults.sqlproxyImageTag | string | `"1.25.0-alpine"` | Image tag to use for the Cloud SQL Proxy |
| defaults.sqlproxyShell | list | `["sh","-c"]` | Docker command directive to invoke a shell in the container, to expand proxyArgs* values |
| migrationJobs | list | None by default, one entry here required per migration | Specific migrations to run; each config merged over the defaults to form the full configuration |
| migrationJobs[0].name | string | `nil` | Required name of this specific migration |
