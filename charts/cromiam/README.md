cromiam
=======

Chart for cromiam service in Terra [WIP]



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.applicationVersion | string | `"latest"` | What version of the cromiam application to deploy |
| imageRepository | string | `"broadinstitute/cromiam"` | Image repo to pull cromiam images from |
| imageTag | string | `nil` | Image tag to be used when deploying Pods @default global.applicationVersion |
| ingress.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` | Load balancer backend timeout |
| replicas | int | `3` | Number of replicas for the deployment |
| resources.limits.cpu | int | `2` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"13Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `2` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"13Gi"` | Memory to request for the deployment |
