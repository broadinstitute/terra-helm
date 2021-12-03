# dsp-argocd

![Version: 0.33.0](https://img.shields.io/badge/Version-0.33.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Helm Chart with extra resources for the DSP ArgoCD instance

A Helm chart for the [DSP ArgoCD instance](https://argocd.dsp-devops.broadinstitute.org/) (must be logged in to Broad VPN to access).

This chart declares the official ArgoCD chart as a subchart, supplies custom values that are used to run ArgoCD in the DSP Tools cluster, and adds custom resources, including [ArgoCD apps and projects](https://argoproj.github.io/argo-cd/operator-manual/declarative-setup/).

## Upgrading ArgoCD

1. [Build an updated custom repo server image](https://github.com/broadinstitute/terra-helmfile-images/blob/main/cloudbuild.yaml#L33) and update `repoServer.image.tag` to point to the new image `values.yaml`

2. If there is an image tag override `global.image.tag` in `values.yaml`, either remove it or update it to the desired version.

3. Update the version of the `argo-cd` chart dependency in Chart.yaml and follow the "Deploying Changes" steps described below.

## Deploying Changes to This Chart

Install the [helm-diff](https://github.com/databus23/helm-diff) plugin.

Authenticate to the dsp-tools cluster:

    gcloud container clusters get-credentials dsp-tools --project=dsp-tools-k8s

Update dependencies (this should be re-run any time you update the chart):

    helm dependency build local-charts/dsp-argocd-notifications
    helm dependency build

Compare local copy of the chart to the deployed version of the chart:

    helm diff upgrade ap-argocd . --namespace=ap-argocd -f values.yaml

If everything looks as expected, perform the upgrade:

    helm upgrade ap-argocd . --namespace=ap-argocd -f values.yaml

Be sure to commit any changes you make back to master!

## Adding a New Cluster

Download [the ArgoCD CLI](https://argoproj.github.io/argo-cd/cli_installation/).

Authenticate the CLI to the ArgoCD web app

    argocd login --sso --grpc-web ap-argocd.dsp-devops.broadinstitute.org:443

Authenticate to the cluster with `gcloud` if you have not yet done so:

    gcloud container clusters get-credentials --project=<project> <cluster name>

Add the cluster to ArgoCD:

    argocd cluster add <gke-cluster-name> --name <cluster name>

where <gke-cluster-name> is the name of the cluster entry that `gcloud`, and <cluster name

    argocd cluster add gke_broad-dsde-perf_us-central1-a_terra-perf --name=terra-perf

## Initial Installation

The following manual steps were followed when deploying ArgoCD for the first time.

## Initial deployment / Manual setup

Configure kubectl

    gcloud container clusters get-credentials dsp-tools --project=dsp-tools-k8s

Create namespace

    kubectl create namespace ap-argocd

Deploy this chart

    helm install ap-argocd . --namespace=ap-argocd

### Change Local Admin password

    # Get current admin password (it's the pod name)
    kubectl get pods -n ap-argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2

    # Set up port forwarding
    kubectl port-forward service/ap-argocd-server -n ap-argocd 8080:443

    # Log in and change password
    argocd login localhost:8080 --username admin
    argocd account update-password

    # Update admin password in Vault
    vault write secret/suitable/ap-argocd/local-accounts/admin \
      username=admin password=<configured-password>

### Generate and save API token for terra-ci account

    # Generate API token
    argocd account generate-token --account terra-ci

### Configure Projects & Applications

These steps will be migrated to a declarative configuration at some point, but for now:

    # Add terra-dev GKE cluster
    argocd cluster add gke_broad-dsde-dev_us-central1-a_terra-dev

    # Configure repository
    argocd repo add https://github.com/broadinstitute/terra-env-helm \
       --name terra-env-helm --type git \
       --username ignored --password <GITHUB TOKEN>

    # Create new project for non-prod Terra environments
    argocd proj create terra --description "Non-production test/integration environments for Terra"

    # Add helm chart repo as a source
    argocd proj add-source terra https://github.com/broadinstitute/terra-env-helm

    # Add terra-dev cluster, with terra-dev namespace, as a destination
    argocd proj add-destination terra https://35.238.186.116 terra-dev

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| DSP DevOps | dsp-devops@broadinstitute.org |  |

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts/dsp-argocd>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://local-charts/dsp-argocd-notifications | notifications(dsp-argocd-notifications) | 0.0.1 |
| https://argoproj.github.io/argo-helm | argo-cd | 3.12.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apps.ghaRunner.controller.chart | string | `"dsp-gha-runner-controller"` |  |
| apps.ghaRunner.controller.version | string | `"0.2.0"` |  |
| apps.ghaRunner.instances.chart | string | `"dsp-gha-runner-instances"` |  |
| apps.ghaRunner.instances.version | string | `"0.7.0"` |  |
| apps.ghaRunner.namespace | string | `"gha-runner"` |  |
| apps.ghaRunner.notificationChannel | string | `"ap-k8s-monitor"` |  |
| argo-cd.controller.extraArgs[0] | string | `"--repo-server-timeout-seconds=180"` |  |
| argo-cd.controller.nodeSelectors.name | string | `"n2-standard-32"` |  |
| argo-cd.controller.resources.requests.cpu | int | `6` |  |
| argo-cd.controller.resources.requests.memory | string | `"8Gi"` |  |
| argo-cd.controller.tolerations[0].effect | string | `"NoSchedule"` |  |
| argo-cd.controller.tolerations[0].key | string | `"bio.terra/node-pool"` |  |
| argo-cd.controller.tolerations[0].operator | string | `"Equal"` |  |
| argo-cd.controller.tolerations[0].value | string | `"n2-standard-32"` |  |
| argo-cd.repoServer.env[0].name | string | `"VAULT_ADDR"` |  |
| argo-cd.repoServer.env[0].value | string | `"https://clotho.broadinstitute.org:8200"` |  |
| argo-cd.repoServer.env[1].name | string | `"VAULT_ROLE_ID"` |  |
| argo-cd.repoServer.env[1].valueFrom.secretKeyRef.key | string | `"roleid"` |  |
| argo-cd.repoServer.env[1].valueFrom.secretKeyRef.name | string | `"ap-argocd-reposerver-vault"` |  |
| argo-cd.repoServer.env[2].name | string | `"VAULT_SECRET_ID"` |  |
| argo-cd.repoServer.env[2].valueFrom.secretKeyRef.key | string | `"secretid"` |  |
| argo-cd.repoServer.env[2].valueFrom.secretKeyRef.name | string | `"ap-argocd-reposerver-vault"` |  |
| argo-cd.repoServer.env[3].name | string | `"ARGOCD_GIT_MODULES_ENABLED"` |  |
| argo-cd.repoServer.env[3].value | string | `"false"` |  |
| argo-cd.repoServer.image.repository | string | `"us-central1-docker.pkg.dev/dsp-artifact-registry/terra-helmfile-images/argocd-custom-image"` |  |
| argo-cd.repoServer.image.tag | string | `"main-00fe213"` |  |
| argo-cd.repoServer.nodeSelectors.name | string | `"n2-standard-32"` |  |
| argo-cd.repoServer.resources.requests.cpu | int | `24` |  |
| argo-cd.repoServer.resources.requests.memory | string | `"16Gi"` |  |
| argo-cd.repoServer.tolerations[0].effect | string | `"NoSchedule"` |  |
| argo-cd.repoServer.tolerations[0].key | string | `"bio.terra/node-pool"` |  |
| argo-cd.repoServer.tolerations[0].operator | string | `"Equal"` |  |
| argo-cd.repoServer.tolerations[0].value | string | `"n2-standard-32"` |  |
| argo-cd.server.config."accounts.fc-jenkins" | string | `"apiKey"` |  |
| argo-cd.server.config."accounts.fcprod-jenkins" | string | `"apiKey"` |  |
| argo-cd.server.config."accounts.local-notsuitable" | string | `"login"` |  |
| argo-cd.server.config."accounts.local-suitable" | string | `"login"` |  |
| argo-cd.server.config."accounts.terra-ci" | string | `"apiKey"` |  |
| argo-cd.server.config."accounts.wsmtest-sync" | string | `"apiKey"` |  |
| argo-cd.server.config."dex.config" | string | `"connectors:\n  - type: github\n    id: github\n    name: GitHub\n    config:\n      clientID: 44eb2e55b99be9fef021\n      clientSecret: $dex.github.clientSecret\n      orgs:\n      - name: DataBiosphere\n      - name: broadinstitute\n"` |  |
| argo-cd.server.config.configManagementPlugins | string | `"- name: legacy-configs\n  generate:\n    command: [\"legacy-configs.sh\"]\n- name: helmfile\n  init:\n    command: [\"helmfile.sh\", \"init\"]\n  generate:\n    command: [\"helmfile.sh\", \"generate\"]\n- name: helm-values\n  init:\n    command: [\"helm-values.sh\", \"init\"]\n  generate:\n    command: [\"helm-values.sh\", \"generate\"]\n- name: terra-helmfile-argocd\n  generate:\n    command: [\"terra-helmfile-argocd.sh\", \"generate\"]\n- name: terra-helmfile-app\n  generate:\n    command: [\"terra-helmfile-app.sh\", \"generate\"]\n"` |  |
| argo-cd.server.config.url | string | `"https://ap-argocd.dsp-devops.broadinstitute.org"` |  |
| argo-cd.server.extraArgs[0] | string | `"--insecure"` |  |
| argo-cd.server.ingress.annotations."kubernetes.io/ingress.allow-http" | string | `"false"` |  |
| argo-cd.server.ingress.annotations."kubernetes.io/ingress.global-static-ip-name" | string | `"ap-argocd-server"` |  |
| argo-cd.server.ingress.enabled | bool | `true` |  |
| argo-cd.server.ingress.pathType | string | `"ImplementationSpecific"` |  |
| argo-cd.server.ingress.paths[0] | string | `"/*"` |  |
| argo-cd.server.ingress.tls[0].hosts[0] | string | `"ap-argocd.dsp-devops.broadinstitute.org"` |  |
| argo-cd.server.ingress.tls[0].secretName | string | `"dsp-argocd-cert"` |  |
| argo-cd.server.rbacConfig."policy.csv" | string | `"g, broadinstitute:DSP DevOps, role:admin\np, role:terra-ci, applications, sync, */*, allow\np, role:terra-ci, applications, action/apps/Deployment/restart, */*, allow\ng, terra-ci, role:terra-ci\np, role:wsmtest-sync, applications, sync, terra-wsmtest/workspacemanager-wsmtest, allow\ng, wsmtest-sync, role:wsmtest-sync\n"` |  |
| argo-cd.server.rbacConfig."policy.default" | string | `"role:readonly"` |  |
| argo-cd.server.service.annotations."cloud.google.com/backend-config" | string | `"{\"default\": \"dsp-argocd-backendconfig\"}"` |  |
| argo-cd.server.service.type | string | `"NodePort"` |  |
| projects.dspCi.cluster | string | `"https://104.197.236.29"` |  |
| vault.pathPrefix | string | `"secret/suitable/argocd"` |  |