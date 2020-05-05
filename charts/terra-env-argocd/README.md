# terra-env-argocd

This Helm chart generates ArgoCD Project and Application definitions for a Terra environment, in accordance with the [ArgoCD app-of-apps pattern](https://argoproj.github.io/argo-cd/operator-manual/cluster-bootstrapping/#app-of-apps-pattern).

It is intended to be deployed once for each Terra environment, using Values from the Terra Helmfile repo.
