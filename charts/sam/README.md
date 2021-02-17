sam
===
Chart for Sam, the Terra Identity and Access Management application

Current chart version is `0.6.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.applicationVersion | string | `"latest"` | What version of the Sam application to deploy |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"gcr.io/broad-dsp-gcr-public/sam"` | Image repository |
| imageConfig.tag | string | global.applicationVersion | Image tag. |
| ingress.cert.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.cert.vault.cert.path | string | `nil` | Path to secret containing .crt |
| ingress.cert.vault.cert.secretKey | string | `nil` | Key in secret containing .crt |
| ingress.cert.vault.enabled | bool | `true` |  |
| ingress.cert.vault.key.path | string | `nil` | Path to secret containing .key |
| ingress.cert.vault.key.secretKey | string | `nil` | Key in secret containing .key |
| ingress.enabled | bool | `true` | Whether to create Ingress, Service and associated config resources |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` |  |
| legacyResourcePrefix | string | `nil` | What prefix to use to refer to secrets rendered from firecloud-develop @default .Chart.Name |
| name | string | `"sam"` | A name for the deployment that will be substituted into resuorce definitions |
| probes.liveness.failureThreshold | int | `30` | How many times the liveness check can fail before the container is restarted |
| probes.liveness.initialDelaySeconds | int | `60` | Initial delay before attempting to check liveness |
| probes.liveness.periodSeconds | int | `10` | How often to check liveness |
| probes.readiness.failureThreshold | int | `6` | How many times the readiness check can fail before the container is marked unhealthy |
| probes.readiness.initialDelaySeconds | int | `60` | Initial delay before attempting to check readiness |
| probes.readiness.periodSeconds | int | `10` | How often to check if the app is ready |
| prometheus.enabled | bool | `true` |  |
| prometheus.initContainerImage | string | `"alpine:3.12.0"` |  |
| prometheus.jmxJarRepo | string | `"https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent"` |  |
| prometheus.jmxJarVersion | string | `"0.13.0"` |  |
| proxy.logLevel | string | `"warn"` |  |
| replicas | int | `0` | Number of replicas for the deployment |
| resources.limits.cpu | int | `4` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"16Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `4` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"16Gi"` | Memory to request for the deployment |
