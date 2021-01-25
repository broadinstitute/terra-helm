opendj
======
Chart for OpenDJ, used by Sam(Terra IAM service) as well as various Terra applications' OIDC proxy deploys

Current chart version is `0.1.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity map |
| baseDn | string | `nil` | Base dn used for health checks. If left empty a base dn of "" is used. |
| global.applicationVersion | string | `"opendj600"` | What version of the application to deploy |
| global.trustedAddresses | object | `{}` | A map of addresses that will be merged with serviceAllowedAddresses. Example: `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"broadinstitute/openam"` | Image repository |
| imageConfig.tag | string | global.applicationVersion | Image tag. |
| legacyResourcePrefix | string | `nil` | What prefix to use to refer to secrets rendered from firecloud-develop @default .Chart.Name |
| name | string | `"opendj"` | A name for the deployment that will be substituted into resuorce definitions |
| nodeSelector | object | `{}` | nodeSelector map |
| persistence.capacity | string | `"200Gi"` | Capacity of persistent data volume |
| persistence.gcpDisk | string | `nil` | If not null, the chart will attempt to use a GCP disk with the provided name for the data volume |
| replicas | int | `1` | Number of replicas for the deployment |
| resources.limits.cpu | int | `64` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"60Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `64` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"60Gi"` | Memory to request for the deployment |
| service.allowedAddresses | object | `{}` | A map of addresses in the form `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
| service.firewallEnabled | bool | `true` | Whether to restrict access to the service to the IPs supplied via service.allowedAddresses |
| service.staticIp | string | `nil` | External IP of the service. Required. |
| tolerations | list | `[]` | Array of tolerations |
