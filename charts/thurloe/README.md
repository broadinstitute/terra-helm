# thurloe

Chart for Thurloe service in Terra

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.applicationVersion | string | `"latest"` | What version of the Thurloe application to deploy |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"gcr.io/broad-dsp-gcr-public/thurloe"` | Image repository |
| imageConfig.tag | string | global.applicationVersion | Image tag. |
| ingress.cert.vault.cert.path | string | `nil` | Path to secret containing .crt |
| ingress.cert.vault.cert.secretKey | string | `nil` | Key in secret containing .crt |
| ingress.cert.vault.enabled | bool | `false` |  |
| ingress.cert.vault.key.path | string | `nil` | Path to secret containing .key |
| ingress.cert.vault.key.secretKey | string | `nil` | Key in secret containing .key |
| ingress.enabled | bool | `true` | Whether to create Ingress, Service and associated config resources |
| ingress.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` |  |
| name | string | `"thurloe"` |  |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/status"` |  |
| probes.liveness.spec.httpGet.port | int | `8000` |  |
| probes.liveness.spec.initialDelaySeconds | int | `20` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.successThreshold | int | `1` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `6` |  |
| probes.readiness.spec.httpGet.path | string | `"/status"` |  |
| probes.readiness.spec.httpGet.port | int | `8000` |  |
| probes.readiness.spec.initialDelaySeconds | int | `20` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `5` |  |
| probes.startup.enabled | bool | `true` |  |
| probes.startup.spec.failureThreshold | int | `1080` |  |
| probes.startup.spec.httpGet.path | string | `"/status"` |  |
| probes.startup.spec.httpGet.port | int | `8000` |  |
| probes.startup.spec.periodSeconds | int | `10` |  |
| probes.startup.spec.successThreshold | int | `1` |  |
| probes.startup.spec.timeoutSeconds | int | `5` |  |
| prometheus.enabled | bool | `true` |  |
| prometheus.initContainerImage | string | `"alpine:3.12.0"` |  |
| prometheus.jmxJarRepo | string | `"https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent"` |  |
| prometheus.jmxJarVersion | string | `"0.13.0"` |  |
| proxyImage | string | `"broadinstitute/openidc-proxy:tcell_3_1_0"` |  |
| replicas | int | `0` |  |
| resources.limits.cpu | int | `4` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"8Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `4` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"8Gi"` | Memory to request for the deployment |
| startupSleep | int | `30` |  |
