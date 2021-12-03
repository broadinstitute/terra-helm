# config-connector

![Version: 1.2.0](https://img.shields.io/badge/Version-1.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Chart to add the Google Config Connector configuration file

This chart does not enable Config Connector on its own! The only step it can do is make the configuration file
that Google requires **once Config Connector has already been enabled in the cluster**.

In other words, this is step three (["Configuring Config Connector"](https://cloud.google.com/config-connector/docs/how-to/install-upgrade-uninstall#addon-configuring))
of the [installation instructions](https://cloud.google.com/config-connector/docs/how-to/install-upgrade-uninstall#addon-install).
The terra-cluster module in ap-deployments can handle the first two steps and the last step is namespace annotations
([which must be done manually](https://github.com/helm/helm/issues/3503)).

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>
* <https://cloud.google.com/config-connector/docs/how-to/install-upgrade-uninstall#addon-configuring>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| googleProjectID | string | `nil` | The ID of the project to containing the `googleServiceAccountName`, e.g. broad-dsp-eng-tools |
| googleServiceAccountName | string | `"config-connector"` | The name of the GSA in `googleProjectID` that's been set up for Config Connector |
