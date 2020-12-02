sam
===
Chart for Sam, the Terra Identity and Access Management application

Current chart version is `0.1.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| allowedAddresses | object | `{}` | What source IPs to whitelist for access to the service |
| global.applicationVersion | string | `"latest"` | What version of the Cromwell application to deploy |
| global.trustedAddresses | object | `{}` | A map of addresses that will be merged with allowedAddresses. Example: `{ "nickname": ["x.x.x.x/y", "x.x.x.x/y"] }` |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"gcr.io/broad-dsp-gcr-public/sam"` | Image repository |
| imageConfig.tag | string | global.applicationVersion | Image tag. |
| ingressCert.cert.path | string | `nil` | Path to secret containing .crt |
| ingressCert.cert.secretKey | string | `nil` | Key in secret containing .crt |
| ingressCert.key.path | string | `nil` | Path to secret containing .key |
| ingressCert.key.secretKey | string | `nil` | Key in secret containing .key |
| ingressIpName | string | `nil` | Name of GCP global static external IP address. Required. |
| legacyResourcePrefix | string | `nil` | What prefix to use to refer to secrets rendered from firecloud-develop @default .Chart.Name |
| name | string | `"sam"` | A name for the deployment that will be substituted into resuorce definitions |
| replicas | int | `0` | Number of replicas for the deployment |
| resources.limits.cpu | int | `4` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"16Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `4` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"16Gi"` | Memory to request for the deployment |
