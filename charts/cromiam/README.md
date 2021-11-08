# cromiam

Chart for cromiam service in Terra [WIP]

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://terra-helm.storage.googleapis.com | ingresslib | 0.12.0 |
| https://terra-helm.storage.googleapis.com | sherlock-reporter | 0.3.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| annotations | object | `{}` |  |
| global.applicationVersion | string | `"latest"` | What version of the cromiam application to deploy |
| imageRepository | string | `"broadinstitute/cromiam"` | Image repo to pull cromiam images from |
| imageTag | string | `nil` | Image tag to be used when deploying Pods @default global.applicationVersion |
| ingress.cert.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.enabled | bool | `true` | Whether to create Ingress and associated Service, FrontendConfig and BackendConfig |
| ingress.requestPath | string | `"/engine/latest/version"` |  |
| ingress.securityPolicy | string | `nil` | Name of a GCP CloudArmor policy to associate with this Ingress |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` | Load balancer backend timeout |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/engine/latest/version"` |  |
| probes.liveness.spec.httpGet.port | int | `8000` |  |
| probes.liveness.spec.initialDelaySeconds | int | `20` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.successThreshold | int | `1` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `6` |  |
| probes.readiness.spec.httpGet.path | string | `"/engine/latest/version"` |  |
| probes.readiness.spec.httpGet.port | int | `8000` |  |
| probes.readiness.spec.initialDelaySeconds | int | `20` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `5` |  |
| probes.startup.enabled | bool | `true` |  |
| probes.startup.spec.failureThreshold | int | `1080` |  |
| probes.startup.spec.httpGet.path | string | `"/engine/latest/version"` |  |
| probes.startup.spec.httpGet.port | int | `8000` |  |
| probes.startup.spec.periodSeconds | int | `10` |  |
| probes.startup.spec.successThreshold | int | `1` |  |
| probes.startup.spec.timeoutSeconds | int | `5` |  |
| proxyImage | string | `"broadinstitute/openidc-proxy:tcell_3_1_0"` | Image that the OIDC proxy uses |
| replicas | int | `3` | Number of replicas for the deployment |
| resources.limits.cpu | int | `2` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"13Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `2` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"13Gi"` | Memory to request for the deployment |
| sherlock.appImageName | string | `"broadinstitute/cromiam"` |  |
| sherlock.appName | string | `"cromiam"` |  |
| sherlock.enabled | bool | `true` |  |
| sherlock.sherlockImageTag | string | `"v0.0.15"` |  |
| sherlock.vault.pathPrefix | string | `"secret/suitable/sherlock/prod"` |  |
