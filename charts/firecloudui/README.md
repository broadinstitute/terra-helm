# firecloudui

Chart for Firecloud UI service in Terra

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://terra-helm.storage.googleapis.com | ingresslib | 0.12.0 |
| https://terra-helm.storage.googleapis.com | pdb-lib | 0.4.0 |
| https://terra-helm.storage.googleapis.com | sherlock-reporter | 0.3.0 |

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
| global.name | string | `"firecloudui"` | Name for this deployment |
| ingress.cert.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.cert.vault.cert.path | string | `nil` | Path to secret containing .crt |
| ingress.cert.vault.cert.secretKey | string | `nil` | Key in secret containing .crt |
| ingress.cert.vault.enabled | bool | `false` |  |
| ingress.cert.vault.key.path | string | `nil` | Path to secret containing .key |
| ingress.cert.vault.key.secretKey | string | `nil` | Key in secret containing .key |
| ingress.enabled | bool | `true` | Whether to create Ingress and associated Service, FrontendConfig and BackendConfig |
| ingress.requestPath | string | `"/health"` | Request path to which the probe system should connect |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `"nul"` | (string) Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` | Load balancer backend timeout |
| replicas | int | `2` | Number of replicas to spin up in the deployment |
| sherlock.appImageName | string | `"gcr.io/broad-dsp-gcr-public/firecloud-ui"` |  |
| sherlock.appName | string | `"firecloudui"` |  |
| sherlock.enabled | bool | `true` |  |
| sherlock.sherlockImageTag | string | `"v0.0.15"` |  |
| sherlock.vault.pathPrefix | string | `"secret/suitable/sherlock/prod"` |  |
