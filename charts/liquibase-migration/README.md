# liquibase-migration

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Chart to run Liquibase migrations before Terra app startup

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>

helm-docs can't parse all the comments in the values file, [see it for more detail](./values.yaml).

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| defaults | object | See sub-keys | Baseline configuration used for each enumerated migration; any key here will be fully overridden by a same-name key in an enumerated configuration (required values can be omitted here if always overridden) |
| defaults.enabled | bool | `false` | Whether to enable migrations by default |
| defaults.k8sAppName | string | `nil` | Name of the application being deployed |
| defaults.k8sLabelRef | string | `nil` | Template reference to use to obtain resource labels, set to empty to disable |
| defaults.k8sServiceAccount | string | `nil` | App's Kubernetes service account (selective sync may be necessary if the KSA isn't applied before k8sSyncWave) |
| defaults.k8sSyncWave | string | `"-1"` | (string) Argo CD wave to apply resources in |
| defaults.migrationArgsAdditional | string | `nil` | Optional arbitrary additional arguments to be passed, from https://docs.liquibase.com/commands/home.html |
| defaults.migrationArgsConfigChangelog | string | `nil` | Java classpath location of the Liquibase changelog file, expanded by migrationShell |
| defaults.migrationArgsConfigDriver | string | `nil` | Java class name of the JDBC driver to use, expanded by migrationShell |
| defaults.migrationArgsConfigUrl | string | `nil` | JDBC URL of the database, expanded by migrationShell |
| defaults.migrationArgsJarLocation | string | `nil` | Path within the migration image to the `.jar` containing Liquibase |
| defaults.migrationArgsLiquibaseCommand | string | `"update"` | If the Kubernetes job should always succeed regardless of the Liquibase command's exit status |
| defaults.migrationConfigFileMount | object | With the secret name omitted, no configuration file will be mounted or passed | Controls for mounting and passing a Liquibase.properties file (necessary unless all other migrationConfigArgs* values passed) |
| defaults.migrationConfigFileMount.mountFilePath | string | `"/etc/liquibase.properties"` | The full mount path of the file, ending with the file itself |
| defaults.migrationConfigFileMount.secretName | string | `nil` | The exact name of a Kubernetes secret containing the desired file under a file-named key |
| defaults.migrationDatabaseCredentials | object | None | Controls for setting up database authentication, one sub-object must be provided |
| defaults.migrationDatabaseCredentials.existingKubernetesSecret | object | With the secret name omitted, no existing Kubernetes secret will be accessed | Use an existing Kubernetes secret for credentials directly |
| defaults.migrationDatabaseCredentials.existingKubernetesSecret.name | string | `nil` | Name of the existing Kubernetes secret to use |
| defaults.migrationDatabaseCredentials.existingKubernetesSecret.passwordKey | string | `nil` | Key of the password within the Kubernetes secret |
| defaults.migrationDatabaseCredentials.existingKubernetesSecret.usernameKey | string | `nil` | Key of the username within the Kubernetes secret |
| defaults.migrationDatabaseCredentials.fromVaultSecret | object | With the Vault secret path omitted, no Vault secret will be accessed | Create a Kubernetes secret via secrets-manager from a Vault secret |
| defaults.migrationDatabaseCredentials.fromVaultSecret.passwordKey | string | `nil` | Key of the password within the Vault secret |
| defaults.migrationDatabaseCredentials.fromVaultSecret.path | string | `nil` | Path of the existing Vault secret to use |
| defaults.migrationDatabaseCredentials.fromVaultSecret.usernameKey | string | `nil` | Key of the username within the Vault secret |
| defaults.migrationDelay | string | `"15s"` | Time to wait before attempting to start Liquibase, to allow proxy to boot |
| defaults.migrationImage | string | `nil` | Image to use for the migration, usually the application image with bundled Liquibase |
| defaults.migrationImageTag | string | `nil` | Image tag to use for the migration image; **warning** that setting this can cause inconsistent migrations (default recommended) |
| defaults.migrationShell | list | `["bash","-c"]` | Docker command directive to invoke a shell in the container, to expand migrationArgs* values |
| defaults.proxyArgsInstances | string | Mimics behavior of legacy broadinstitute/cloudsqlproxy image | Instances argument passed to the proxy executable, expanded by proxyShell |
| defaults.proxyArgsMaxConnections | string | Mimics behavior of legacy broadinstitute/cloudsqlproxy image | Max connections argument passed to the proxy executable, expanded by proxyShell |
| defaults.proxyContainerConfig | object | `nil` | Extra configuration applied directly to the proxy container (useful for env or envFrom directives) |
| defaults.proxyCredentialFileMount | object | With the secret name omitted, no credentials file will be mounted or passed | Controls for mounting and passing a credentials file (necessary unless Workload Identity or another mechanism configured) |
| defaults.proxyCredentialFileMount.mountFilePath | string | `"/etc/sqlproxy-service-account.json"` | The full mount path of the file, ending with the file itself |
| defaults.proxyCredentialFileMount.secretName | string | `nil` | The exact name of a Kubernetes secret containing the desired file under a file-named key |
| defaults.proxyImage | string | `"gcr.io/cloudsql-docker/gce-proxy"` | Image to use for the Cloud SQL Proxy |
| defaults.proxyImageTag | string | `"1.25.0-alpine"` | Image tag to use for the Cloud SQL Proxy |
| defaults.proxyShell | list | `["sh","-c"]` | Docker command directive to invoke a shell in the container, to expand proxyArgs* values |
| enumerated | list | None by default, one entry here required per migration | Specific migrations to run; each configuration key fully overrides any same-name key in the defaults |
| enumerated[0].name | string | `nil` | Required name of this specific migration |
