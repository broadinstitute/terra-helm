terra-argocd-env
================
A Helm chart for generating environment-wide ArgoCD resources for Terra environments

Current chart version is `0.0.7`



## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://broadinstitute.github.io/terra-helm | terra-argocd-templates | 0.0.4 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterAddresses | list | `[]` | A list of cluster addresses that this environment is deployed to. Eg. "https://35.238.186.116" |
| environment | string | `nil` | The Terra environment this project is for. Eg. `dev` |
| requireSuitable | bool | `false` | Whether this environment requires a user to be suitable to make changes. |
