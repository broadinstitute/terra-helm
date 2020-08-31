leonardo
========
A Helm chart for Leonardo, Terra's Jupyter notebook integration service

Current chart version is `0.0.1`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| deploymentDefaults.enabled | bool | `true` | Whether a declared deployment is enabled. If false, no resources will be created |
| deploymentDefaults.expose | bool | `false` | Whether to create a Service + Ingress for this deployment |
| deploymentDefaults.imageRepository | string | `"gcr.io/broad-dsp-gcr-public/leonardo"` | Image repo to pull Leonardo images from |
| deploymentDefaults.imageTag | string | `nil` | Image tag to be used when deploying Pods @default global.applicationVersion |
| deploymentDefaults.name | Required | `nil` | A name for the deployment that will be substituted into resource definitions. Example: `"leonardo-backend"` |
| deploymentDefaults.replicas | int | `0` | Number of replicas for the deployment |
| deploymentDefaults.serviceIP | string | `nil` | Static IP to use for the Service. (optional) |
| deployments.standalone.expose | bool | `true` | Whether to expose the default standalone Leonardo deployment as a service |
| deployments.standalone.name | string | `"leonardo"` | Name to use for the default standalone Leonardo deployment |
| deployments.standalone.replicas | int | `1` | Number of replicas in the default standalone Leonardo deployment |
| deployments.standalone.serviceName | string | `"leonardo"` | Name of the default standalone Leonardo service |
| global.applicationVersion | string | `"latest"` | What version of the Leonardo application to deploy |
