DUOS Ontology
========
A Helm chart for DUOS Ontology, the DUOS Algorithmic Matching System

Current chart version is `0.1.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| devDeploy | bool | `false` | Enable to deploy to dev locally with Skaffold |
| appVersion | string | Is set by Helmfile on deploy | Workspace Manager image version/tag. Required unless using `image`. |
| environment | string | `nil` | Environment, [dev, staging, prod] |
| elasticSearch.servers | array | `nil` | List of elastic search hosts |
| sentry.dsn.path | string | `nil` | Vault path to secret containing Sentry DSN value |
| sentry.dsn.key | string | `nil` | Vault key of secret containing Sentry DSN value |
| vault.enabled | bool | `true` | When enabled, syncs required secrets from Vault |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
