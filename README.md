# terra-helm
A helm repo for Terra from Broad Data Science Platforms Group



## How Do I install the repo?
```
helm repo add terra-helm https://broadinstitute.github.io/terra-helm
helm repo update
```
## How Do I Install These Charts?

Just `helm install terra-helm/<chart>`. This is the default repository for Helm which is located at https://broadinstitute.github.io/terra-helm/ and is installed by default.

For more information on using Helm, refer to the [Helm documentation](https://github.com/kubernetes/helm#docs).

## How are new chart versions released?

This repo is configured to use the [chart-releaser GitHub Action](https://github.com/helm/chart-releaser-action). On every commit to master, it checks if there are version updates to any charts. If there are, it automatically creates new releases for them and publishes them to the Helm repo hosted on this repo's GitHub pages.
