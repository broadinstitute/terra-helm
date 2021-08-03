# dsp-argocd

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

    helm diff upgrade ap-argocd . --namespace=ap-argocd

If everything looks as expected, perform the upgrade:

    helm upgrade ap-argocd . --namespace=ap-argocd

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
