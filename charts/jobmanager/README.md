jobmanager
==========

Chart for Job Manager service in Terra



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| api.imageConfig.imagePullPolicy | string | `"Always"` |  |
| api.imageConfig.repository | string | `"databiosphere/job-manager-api-cromwell"` | Image repository |
| api.imageConfig.tag | string | global.applicationVersion | Image tag. |
| api.probes.liveness.enabled | bool | `true` |  |
| api.probes.liveness.spec | object | `{"failureThreshold":30,"httpGet":{"path":"/api/v1/health","port":8190},"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Kubernetes spec for liveness probe |
| api.probes.readiness.enabled | bool | `true` |  |
| api.probes.readiness.spec | object | `{"failureThreshold":6,"httpGet":{"path":"/api/v1/health","port":8190},"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Kubernetes spec for readiness probe |
| api.resources.limits.cpu | int | `2` | Number of CPU units to limit the deployment to |
| api.resources.limits.memory | string | `"2Gi"` | Memory to limit the deployment to |
| api.resources.requests.cpu | int | `2` | Number of CPU units to request for the deployment |
| api.resources.requests.memory | string | `"2Gi"` | Memory to request for the deployment |
| global.applicationVersion | string | `"latest"` | What version of the jobmanager application to deploy |
| ingress.enabled | bool | `true` | Whether to create Ingress and associated Service, FrontendConfig and BackendConfig |
| ingress.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` | Load balancer backend timeout |
| name | string | `"jobmanager"` | Name for this deployment |
| proxy.imageConfig.imagePullPolicy | string | `"Always"` |  |
| proxy.imageConfig.repository | string | `"broadinstitute/openidc-proxy"` | Image repository |
| proxy.imageConfig.tag | string | `"modsecurity_2_9_2"` | (string) Image tag. |
| replicas | int | `3` | Number of API replicas to spin up in the deployment |
| ui.imageConfig.imagePullPolicy | string | `"Always"` |  |
| ui.imageConfig.repository | string | `"databiosphere/job-manager-ui"` | Image repository |
| ui.imageConfig.tag | string | global.applicationVersion | Image tag. |
| ui.probes.liveness.enabled | bool | `true` |  |
| ui.probes.liveness.spec | object | `{"failureThreshold":30,"httpGet":{"path":"/health","port":443},"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Kubernetes spec for liveness probe |
| ui.probes.readiness.enabled | bool | `true` |  |
| ui.probes.readiness.spec | object | `{"failureThreshold":6,"httpGet":{"path":"/health","port":443},"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Kubernetes spec for readiness probe |
| ui.resources.limits.cpu | int | `4` | Number of CPU units to limit the deployment to |
| ui.resources.limits.memory | string | `"4Gi"` | Memory to limit the deployment to |
| ui.resources.requests.cpu | int | `4` | Number of CPU units to request for the deployment |
| ui.resources.requests.memory | string | `"4Gi"` | Memory to request for the deployment |
