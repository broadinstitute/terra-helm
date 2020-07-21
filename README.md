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

## Documentation

All charts in this repo should be configured to use [helm-docs](https://github.com/norwoodj/helm-docs). If your change affects the values or another part of the README that helm-docs generates, please re-generate the README and commit it with your other changes:
```
brew install norwoodj/tap/helm-docs
cd charts/[changed chart]
helm-docs
```
