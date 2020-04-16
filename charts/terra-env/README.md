# terra-env

An umbrella chart for configuring Terra environments in Kubernetes.

Individual Terra apps should be declared as dependencies/subcharts of this chart.

Cluster-wide resources, such as Prometheus or Secrets Manager, should _not_ be included here.
