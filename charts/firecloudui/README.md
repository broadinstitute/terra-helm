# firecloudui

Chart for Firecloud UI service in Terra

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.image.imagePullPolicy | string | `"Always"` |  |
| app.image.repository | string | `"gcr.io/broad-dsp-gcr-public/firecloud-ui"` | Image repository |
| app.image.tag | string | global.applicationVersion | Image tag. |
| app.probes.liveness.enabled | bool | `true` |  |
| app.probes.liveness.spec | object | `{"failureThreshold":30,"httpGet":{"path":"/health","port":443,"scheme":"HTTPS"},"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Kubernetes spec for liveness probe |
| app.probes.readiness.enabled | bool | `true` |  |
| app.probes.readiness.spec | object | `{"failureThreshold":6,"httpGet":{"path":"/health","port":443,"scheme":"HTTPS"},"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Kubernetes spec for readiness probe |
| app.resources.limits.cpu | int | `1` | Number of CPU units to limit the deployment to |
| app.resources.limits.memory | string | `"3.75Gi"` | Memory to limit the deployment to |
| app.resources.requests.cpu | int | `1` | Number of CPU units to request for the deployment |
| app.resources.requests.memory | string | `"3.75Gi"` | Memory to request for the deployment |
| global.applicationVersion | string | `"latest"` | What version of the firecloudui application to deploy |
| ingress.cert.vault.cert.path | string | `nil` | Path to secret containing .crt |
| ingress.cert.vault.cert.secretKey | string | `nil` | Key in secret containing .crt |
| ingress.cert.vault.enabled | bool | `false` |  |
| ingress.cert.vault.key.path | string | `nil` | Path to secret containing .key |
| ingress.cert.vault.key.secretKey | string | `nil` | Key in secret containing .key |
| ingress.enabled | bool | `true` | Whether to create Ingress and associated Service, FrontendConfig and BackendConfig |
| ingress.healthCheck.requestPath | string | `"/health"` |  |
| ingress.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` | Load balancer backend timeout |
| name | string | `"firecloudui"` | Name for this deployment |
| replicas | int | `2` | Number of replicas to spin up in the deployment |
