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

This repo is configured to use the [chart-releaser GitHub Action](https://github.com/DataBiosphere/github-actions/tree/master/actions/chart-releaser). On every commit to master, it checks if there are version updates to any charts. If there are, it automatically bumps those charts' versions, creates new releases for them and publishes them to the Helm repo hosted on this repo's GitHub pages.

Additionally, this action also runs on every commit in PRs, so that it's possible to deploy and test charts from those commits.

When a new version of a chart becomes available on the master branch, the [`dispatch-on-release` workflow](https://github.com/broadinstitute/terra-helm/blob/master/.github/workflows/dispatch-on-release.yaml) is triggered, which does one of 3 things, depending on the chart's entry in the [`release-strategy.json` file](https://github.com/broadinstitute/terra-helm/blob/master/release-strategy.json):
- Nothing if there is no release strategy
- If the strategy is `{"dev_only": false}`, sends a dispatch to [`terra-helmfile`](https://github.com/broadinstitute/terra-helmfile) to update the [default version file](https://github.com/broadinstitute/terra-helmfile/blob/master/versions.yaml), adding it to the next release train.
- If the strategy is `{"dev_only": true}`, sends a dispatch to `terra-helmfile` to update the [dev version override](https://github.com/broadinstitute/terra-helmfile/blob/master/environments/live/dev.yaml) of the chart. The team responsible for the chart can then later choose to update the default version file when the chart is ready to go on the release train.

## Documentation

All charts in this repo should be configured to use [helm-docs](https://github.com/norwoodj/helm-docs). If your change affects the values or another part of the README that helm-docs generates, please re-generate the README and commit it with your other changes:
```
brew install norwoodj/tap/helm-docs
cd charts/[changed chart]
helm-docs
```
