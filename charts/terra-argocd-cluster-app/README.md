terra-argocd-app
================
A Helm chart for generating ArgoCD resources for a Terra app in an environment

Current chart version is `0.1.2`



## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://broadinstitute.github.io/terra-helm | terra-argocd-templates | 0.0.4 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app | string | `nil` | Name of the application to render for. Eg. `cromwell` |
| clusterAddress | string | `nil` | The address of the cluster that is being deployed to. Eg. "https://35.238.186.116" |
| clusterName | string | `nil` | The name of the cluster that is being deployed to. Eg. terra-dev |
| environment | string | `nil` | The Terra environment the app belongs to |
| helmfileRepo | string | `"https://github.com/broadinstitute/terra-helmfile"` | Terra's helmfile repo |
| jenkinsSyncEnabled | bool | `true` | Whether to sync this app on Jenkins environment deploys |
| legacyConfigsEnabled | bool | `false` | Whether to create a separate application to sync values from firecloud-develop |
| legacyConfigsEnv | object | documented invidually | Any additional environment variables to pass in to the configure.rb process. |
| legacyConfigsEnv.APP_NAME | string | terra app name passed in via .app value, eg. cromwell | configure.rb app name |
| legacyConfigsEnv.ENV | string | terra env name passed in via .environment value, eg. dev | configure.rb env name |
| legacyConfigsEnv.RUN_CONTEXT | string | live | configure.rb run context |
| legacyConfigsInstanceTypes | list | `[]` | Which instance types to render consul-template configs for (passed to consul-template via INSTANCE_TYPE env var) |
| legacyConfigsRepo | string | `"https://github.com/broadinstitute/firecloud-develop"` | Repo to pull legacy configs from |
| legacyConfigsRepoRef | string | `"dev"` | Branch/ref to pull legacy configs from |
| purgeDeployedResourcesOnDelete | bool | `false` | If an ArgoCD Application is deleted, purge deployed resources as well. Eg. if the `cromwell-dev` app is deleted, delete all the deployed Cromwell pods/secrets/etc from the dev cluster |
| syncPolicy | string | No sync policy (manual) | Optional: Sync policy for the app. See https://argoproj.github.io/argo-cd/user-guide/auto_sync/ |
