opendj
======
Chart for OpenDJ, used by Sam(Terra IAM service) as well as various Terra applications' OIDC proxy deploys

Current chart version is `0.3.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity map |
| global.applicationVersion | string | `"opendj600"` | What version of the application to deploy |
| global.trustedAddresses | object | `{}` | A map of addresses that will be merged with serviceAllowedAddresses. Example: `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"broadinstitute/openam"` | Image repository |
| imageConfig.tag | string | global.applicationVersion | Image tag. |
| legacyResourcePrefix | string | `nil` | What prefix to use to refer to secrets rendered from firecloud-develop @default .Chart.Name |
| name | string | `"opendj"` | A name for the deployment that will be substituted into resuorce definitions |
| nodeSelector | object | `{}` | nodeSelector map |
| persistence.capacity | string | `"200Gi"` | Capacity of persistent data volume |
| persistence.storageClassName | string | `nil` | If not null, the volume will be restricted to the specified storage class |
| replicas | int | `1` | Number of replicas for the deployment |
| resources.limits.cpu | int | `64` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"60Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `64` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"60Gi"` | Memory to request for the deployment |
| service.allowedAddresses | object | `{}` | A map of addresses in the form `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
| service.firewallEnabled | bool | `true` | Whether to restrict access to the service to the IPs supplied via service.allowedAddresses |
| service.ports.admin | bool | `false` | Whether to enable the admin(4444) port |
| service.ports.ldap | bool | `false` | Whether to enable the LDAP(389) port |
| service.ports.ldaps | bool | `true` | Whether to enable the LDAPS(636) port |
| service.staticIp | string | `nil` | External IP of the service. Required. |
| snapshot.enable | bool | `true` | Whether to enable a gcp snapshot policy for the data disk |
| snapshot.policy | string | `"terra-snapshot-policy"` | Name of the snapshot policy to use on data disk |
| tolerations | list | `[]` | Array of tolerations |
