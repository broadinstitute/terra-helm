# dsp-argocd

A Helm chart for the [DSP ArgoCD instance](https://argocd.dsp-devops.broadinstitute.org/) (must be logged in to Broad VPN to access).

This chart declares the official ArgoCD chart as a subchart, supplies custom values that are used to run ArgoCD in the DSP Tools cluster, and adds custom resources, including [ArgoCD apps and projects](https://argoproj.github.io/argo-cd/operator-manual/declarative-setup/).

## Upgrading ArgoCD

1. [Build an updated custom repo server image](https://github.com/broadinstitute/terra-helmfile-images/blob/main/cloudbuild.yaml#L33) and update `repoServer.image.tag` to point to the new image `values.yaml`

2. If there is an image tag override `global.image.tag` in `values.yaml`, either remove it or update it to the desired version.

3. Update the version of the `argo-cd` chart dependency in Chart.yaml and follow the "Deploying Changes" steps described below.

## Deploying Changes to this Chart

Install the [helm-diff](https://github.com/databus23/helm-diff) plugin.

Authenticate to the dsp-tools cluster:

    gcloud container clusters get-credentials dsp-tools --project=dsp-tools-k8s

Compare local copy of the chart to the deployed version of the chart:

  helm diff upgrade ap-argocd . --namespace=ap-argocd

If everything looks as expected, perform the upgrade:

  helm upgrade ap-argocd . --namespace=ap-argocd

Be sure to commit any changes you make back to master!

## Initial Installation

The following manual steps were followed when deploying ArgoCD for the first time.

## Initial deployment / Manual setup

Configure kubectl

    gcloud container clusters get-credentials dsp-tools --project=dsp-tools-k8s

Create namespace

    kubectl create namespace ap-argocd

Create Vault secret for repo server (pull values from secret/suitable/ap-argocd/approle)

    kubectl -n ap-argocd create secret generic ap-argocd-reposerver-vault \
      --from-literal=roleid=<role id>
      --from-literal=secretid=<secret id>

Deploy preinstall chart (no values file needed)

    helm install ap-argocd-preinstall ap-argocd-preinstall \
      --repo https://broadinstitute.github.io/terra-helm \
      --version 0.1.1 \
      --namespace ap-argocd

Deploy official ArgoCD chart

    helm install ap-argocd argo-cd \
      --repo https://argoproj.github.io/argo-helm \
      --version 2.2.2 \
      --namespace ap-argocd \
      -f ./values.yaml

Configure [GitHub OAuth](https://argoproj.github.io/argo-cd/operator-manual/user-management/#dex)

    # Base64-encode the GitHub OAuth client secret
    echo -n <client secret> | base64

    # Take output and add to argocd-secret under the key dex.github.clientSecret
    kubectl edit secret -n ap-argocd argocd-secret

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
