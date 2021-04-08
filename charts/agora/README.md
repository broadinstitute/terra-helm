# agora

Chart for Agora service in Terra

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraHostAliases | list | `[]` | An array of additional hostAliases to add to the pod. See https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/ Currently this is used for replicating host aliases for MongoDB in Terra's dev environment (https://github.com/broadinstitute/dsp-puppet/blob/ba64214a81cf2abd9e0c5c21dc0294d3837481ce/hieradata/c.broad-dsde-dev.internal.eyaml#L308) |
| global.applicationVersion | string | `"latest"` | What version of the agora application to deploy |
| imageRepository | string | `"gcr.io/broad-dsp-gcr-public/agora"` | Image repo to pull agora images from |
| imageTag | string | `nil` | Image tag to be used when deploying Pods @default global.applicationVersion |
| ingress.enabled | bool | `true` | Whether to create Ingress and associated Service, FrontendConfig and BackendConfig |
| ingress.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` | Load balancer backend timeout |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/status"` |  |
| probes.liveness.spec.httpGet.port | int | `8000` |  |
| probes.liveness.spec.initialDelaySeconds | int | `15` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.successThreshold | int | `1` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `6` |  |
| probes.readiness.spec.httpGet.path | string | `"/status"` |  |
| probes.readiness.spec.httpGet.port | int | `8000` |  |
| probes.readiness.spec.initialDelaySeconds | int | `15` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `5` |  |
| probes.startup.enabled | bool | `true` |  |
| probes.startup.spec.failureThreshold | int | `1080` |  |
| probes.startup.spec.httpGet.path | string | `"/version"` |  |
| probes.startup.spec.httpGet.port | int | `8080` |  |
| probes.startup.spec.periodSeconds | int | `10` |  |
| probes.startup.spec.successThreshold | int | `1` |  |
| probes.startup.spec.timeoutSeconds | int | `5` |  |
| replicas | int | `3` | Number of replicas for the deployment |
| resources.limits.cpu | int | `4` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"15Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `4` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"15Gi"` | Memory to request for the deployment |
