leonardo
========

A Helm chart for Leonardo, Terra's Jupyter notebook integration service



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| commonCronjob.reportDestinationBucket | string | `nil` |  |
| cronjob.googleProject | string | `nil` |  |
| cronjob.imageRepository | string | `"us.gcr.io/broad-dsp-gcr-public/resource-validator"` |  |
| cronjob.imageTag | string | `"4bbec1f"` |  |
| cronjob.name | string | `"leonardo-resource-validator-cronjob"` |  |
| deploymentDefaults.enabled | bool | `true` | Whether a declared deployment is enabled. If false, no resources will be created |
| deploymentDefaults.imageRepository | string | `"gcr.io/broad-dsp-gcr-public/leonardo"` | Image repo to pull Leonardo images from |
| deploymentDefaults.imageTag | string | `nil` | Image tag to be used when deploying Pods @default global.applicationVersion |
| deploymentDefaults.name | Required | `nil` | A name for the deployment that will be substituted into resource definitions. Example: `"leonardo-backend"`. The deployment name will be substituted into Deployment and ConfigMap names.   Eg. "leonardo-frontend" -> "leonardo-frontend-deployment", "leonardo-frontend-cm" |
| deploymentDefaults.replicas | int | `0` | Number of replicas for the deployment |
| deployments.standalone.name | string | `"leonardo"` | Name to use for the default standalone Leonardo deployment |
| deployments.standalone.replicas | int | `1` | Number of replicas in the default standalone Leonardo deployment |
| global.applicationVersion | string | `"latest"` | What version of the Leonardo application to deploy |
| ingress.deployment | string | `"leonardo"` | Name of the deployment to associate with the Ingress (should correspond to the "name" field of a deployment, under the deployments key, above) |
| ingress.enabled | bool | `true` | Whether to create Ingress, Service and associated config resources |
| ingress.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `28800` | Load balancer backend timeout (Leonardo has a large backend timeout to support long-lived websockets -- see DDO-132 / IA-1665) |
| monitoring.enabled | bool | `true` | Whether to enable Prometheus monitoring for Leonardo pods |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
| zombieMonitorCron.imageRepository | string | `"us.gcr.io/broad-dsp-gcr-public/zombie-monitor"` |  |
| zombieMonitorCron.imageTag | string | `"4bbec1f"` |  |
| zombieMonitorCron.name | string | `"leonardo-zombie-monitor-cronjob"` |  |
