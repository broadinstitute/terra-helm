DUOS Ontology
========
A Helm chart for DUOS Ontology, the DUOS Algorithmic Matching System

Current chart version is `0.1.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.applicationVersion | string | Is set by Helmfile on deploy | Ontology global version |
| appVersion | string | Is set by Helmfile on deploy | Ontology image version/tag. Required unless using `image`. |
| devDeploy | bool | `false` | Enable to deploy to dev locally with Skaffold |
| environment | string | `nil` | Environment, [dev, staging, prod] |
| elasticSearch.server1 | string | `nil` | first elastic search host |
| elasticSearch.server2 | string | `nil` | second elastic search host |
| elasticSearch.server3 | string | `nil` | third elastic search host |
| google.project | string | `nil` | Google project where GCS files are stored |
| google.subdirectory | string | `nil` | Google bucket subdirectory |
| gcsAccount.path | string | `nil` | Vault path to GCS service account json |
| gcsAccount.key | string | `nil` | Vault key of GCS service account json |
| imageConfig.repository | string | `nil` | GCR image location |
| imageConfig.tag | string | `nil` | GCR image tag |
| sentry.dsn.path | string | `nil` | Vault path to secret containing Sentry DSN value |
| sentry.dsn.key | string | `nil` | Vault key of secret containing Sentry DSN value |
| vault.enabled | bool | `true` | When enabled, syncs required secrets from Vault |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |

## Cheat Sheet

* `gcloud container clusters get-credentials terra-dev --zone us-central1-a --project broad-dsde-dev`
* `kubectl get secrets -n terra-dev`
* `kubectl describe secret ontology-sentry-dsn -n terra-dev`
* `kubectl get configmap -n terra-dev`
* `kubectl describe configmap ontology-configmap -n terra-dev`
* `helmfile -e dev --selector group=terra,app=ontology template`