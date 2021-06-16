# liquibase-migration

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: library](https://img.shields.io/badge/Type-library-informational?style=flat-square)

Library chart to run Liquibase migrations before Terra app startup

> All values with a default of `nil` must be set in values files at the usage site, see below

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| migration.appContainerShell | string | `"bash"` | (string) Shell executable to use in the app's container |
| migration.appName | string | Set to .Release.Name | Name of the application being deployed, for deriving other values |
| migration.ignoreLiquibaseFailures | bool | `false` | (bool) If the Liquibase CLI's exit code should be ignored |
| migration.imageName | string | `nil` | Required full app image name, without trailing tag Like "gcr.io/broad-dsp-gcr-public/rawls" |
| migration.imageTag | string | Set to global.applicationVersion | Tag of the migration.imageName to use WARNING: App may behave unexpectedly if its database has been migrated on a different version than the app itself |
| migration.jarLocation | string | `nil` | Required jar location in app image, expanded by migration.appContainerShell Like "$(find /rawls -name 'rawls*.jar')" |
| migration.labelRef | string | Set to "${appName}.labels" | Template reference to `include` in resource labels |
| migration.liquibaseCommand | string | `"update"` | (string) Liquibase CLI command, can be "updateSQL" for a no-op dry-run  |
| migration.secretPrefix | string | `nil` | Required prefix of -app-ctmpls, -sqlproxy-ctmpls, -sqlproxy-env secrets Like "rawls-backend" |
| migration.serviceAccount | string | Set to "${appName}-sa" | App's k8s service account WARNING: If not applied earlier than migration.syncWave, selective sync may be necessary in cold-start scenarios |
| migration.syncWave | string | `"-1"` | (string) ArgoCD wave to apply these resources in |
| vault.migration.dbPasswordKey | string | `nil` |  |
| vault.migration.dbUsernameKey | string | `nil` | Required key in Vault secret to DB username |
| vault.migration.path | string | `nil` | Required Vault path to secret containing DB credentials |