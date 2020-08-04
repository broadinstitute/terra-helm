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
| elasticSearchServers | array | `nil` | List of elastic search hosts |
| sentry.dsn.path | string | `nil` | Vault path to secret containing Sentry DSN value |
| vault.enabled | bool | `true` | When enabled, syncs required secrets from Vault |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
| vaultCert.cert.path | string | `nil` | Path to secret containing .crt |
| vaultCert.cert.secretKey | string | `nil` | Key in secret containing .crt |
| vaultCert.chain.path | string | `nil` | Path to secret containing intermediate .crt |
| vaultCert.chain.secretKey | string | `nil` | Key in secret containing intermediate .crt |
| vaultCert.enabled | bool | `false` | Enable to sync certificate secret from Vault with secrets-manager |
| vaultCert.key.path | string | `nil` | Path to secret containing .key |
| vaultCert.key.secretKey | string | `nil` | Key in secret containing .key |

