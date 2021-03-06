# cromwell

A Helm chart for Cromwell, the Terra Workflow Management System

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| deploymentDefaults.enabled | bool | `true` | Whether a declared deployment is enabled. If false, no resources will be created |
| deploymentDefaults.expose | bool | `false` | Whether to create a Service for this deployment |
| deploymentDefaults.imageTag | string | `nil` | Image tag to be used when deploying Pods @defautl global.applicationVersion |
| deploymentDefaults.legacyResourcePrefix | string | `nil` | What prefix to use to refer to secrets rendered from firecloud-develop @default deploymentDefaults.name |
| deploymentDefaults.name | string | `nil` | A name for the deployment that will be substituted into resource definitions. Example: `"cromwell1-reader"` |
| deploymentDefaults.nodeSelector | object | `nil` | Optional nodeSelector map |
| deploymentDefaults.probes.liveness.enabled | bool | `true` |  |
| deploymentDefaults.probes.liveness.spec | object | `{"failureThreshold":30,"httpGet":{"path":"/engine/latest/version","port":8000},"initialDelaySeconds":20,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the liveness probe to deploy, if enabled |
| deploymentDefaults.probes.readiness.enabled | bool | `true` |  |
| deploymentDefaults.probes.readiness.spec | object | `{"failureThreshold":6,"httpGet":{"path":"/engine/latest/version","port":8000},"initialDelaySeconds":20,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the readiness probe to deploy, if enabled |
| deploymentDefaults.proxyImage | string | `"broadinstitute/openidc-proxy:tcell-mpm-big"` | Image that the OIDC proxy uses |
| deploymentDefaults.replicas | int | `0` | Number of replicas for the deployment |
| deploymentDefaults.serviceAllowedAddresses | object | `{}` | What source IPs to whitelist for access to the service |
| deploymentDefaults.serviceIP | string | `nil` | Static IP to use for the Service. If set, service will be of type LoadBalancer |
| deploymentDefaults.serviceName | string | `nil` | What to call the Service |
| deploymentDefaults.tolerations | array | `nil` | Optional array of tolerations |
| deployments.standalone.expose | bool | `true` | Whether to expose the default standalone Cromwell deployment as a service |
| deployments.standalone.name | string | `"cromwell"` | Name to use for the default standalone Cromwell deployment |
| deployments.standalone.replicas | int | `1` | Number of replicas in the default standalone Cromwell deployment |
| deployments.standalone.serviceName | string | `"cromwell"` | Name of the default standalone Cromwell service |
| global.applicationVersion | string | `"latest"` | What version of the Cromwell application to deploy |
| global.trustedAddresses | object | `{}` | A map of addresses that will be merged with serviceAllowedAddresses. Example: `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
