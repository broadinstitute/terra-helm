# terra-argocd-project

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for generating Terra ArgoCD projects

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterResourceWhitelist | list | `[]` | Optionally allow applications in this project to deploy cluster-wide resources, such as ClusterRoles |
| description | string | `nil` | Description for this project. Eg. "Applications for Terra dev environment" |
| destinations | list | `[]` | An array of destinations to which this project can deploy, in the form [{ namespace: "target-namespace", server: "https://master-api-address"}] |
| projectName | string | `nil` | Name of this project. Eg. "terra-dev", "terra-cluster-dev" |
| requireSuitable | bool | `false` | Whether this environment or cluster requires a user to be suitable to make changes. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)