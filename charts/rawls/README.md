rawls
=====
Chart for Rawls service in Terra

Current chart version is `0.3.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| deploymentDefaults.enabled | bool | `true` | Whether a declared deployment is enabled. If false, no resources will be created |
| deploymentDefaults.expose | bool | `false` | Whether to create a Service for this deployment |
| deploymentDefaults.imageTag | string | `nil` | Image tag to be used when deploying Pods @defautl global.applicationVersion |
| deploymentDefaults.legacyResourcePrefix | string | `nil` | What prefix to use to refer to secrets rendered from firecloud-develop @default deploymentDefaults.name |
| deploymentDefaults.name | string | `nil` | A name for the deployment that will be substituted into resuorce definitions. Example: `"rawls1-reader"` |
| deploymentDefaults.probes.liveness.enabled | bool | `false` |  |
| deploymentDefaults.probes.liveness.spec | object | `{"failureThreshold":30,"httpGet":{"path":"/status","port":8080},"initialDelaySeconds":20,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the liveness probe to deploy, if enabled |
| deploymentDefaults.probes.readiness.enabled | bool | `true` |  |
| deploymentDefaults.probes.readiness.spec | object | `{"failureThreshold":6,"httpGet":{"path":"/status","port":8080},"initialDelaySeconds":20,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | k8s spec of the readiness probe to deploy, if enabled |
| deploymentDefaults.replicas | int | `0` | Number of replicas for the deployment |
| deploymentDefaults.serviceIP | string | `nil` | Static IP to use for the Service. If set, service will be of type LoadBalancer |
| deploymentDefaults.serviceName | string | `nil` | What to call the Service |
| global.applicationVersion | string | `"latest"` | What version of the rawls application to deploy |
| ingress.preSharedCerts | list | `[]` | (string) List of pre existing gcp certs to use on ingress |
| ingress.serviceName | string | `"rawls-frontend"` | (string) Name of the rawls service to associate with GKE ingress. |
| ingress.sslPolicy | string | `"tls12-ssl-policy"` | (string) Name of an existing google ssl policy to associate with an ingress frontend-config |
| ingress.staticIpName | string | `nil` | Required. GCP resource name for ingress static ip |
| ingress.timeoutSec | int | `120` | Number of seconds to timeout on requests to the ingress |
| resources.limits.cpu | int | `8` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"16Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `8` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"16Gi"` | Memory to request for the deployment |
