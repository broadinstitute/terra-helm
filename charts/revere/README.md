# revere

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Chart for Revere - Terra's Status and Uptime Reporting Service

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>
* <https://github.com/broadinstitute/revere>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| annotations | object | `{}` | (map) Annotations for application pods |
| config | object | `nil` | Required; contents of revere.yaml to be given to the application |
| global.applicationVersion | string | `"latest"` | (string) What version of the application to deploy |
| imageConfig.imagePullPolicy | string | `"Always"` | (string) When to pull images |
| imageConfig.repository | string | `"us-central1-docker.pkg.dev/dsp-artifact-registry/revere/revere"` | (string) Image repository |
| imageConfig.tag | string | `nil` | Image tag |
| name | string | `"revere"` | A name for the deployment that will be substituted into resource definitions |
| networkPolicy.egress.cidrAllowList | list | `["2600:1f18:2146:e300::/56","52.41.219.63/32","34.216.18.129/32","13.236.8.128/25","2406:da1c:1e0:a200::/56","2a05:d014:f99:dd00::/56","2a05:d018:34d:5800::/56","18.246.31.128/25","34.236.25.177/32","185.166.140.0/22","34.199.54.113/32","2600:1f1c:cc5:2300::/56","2600:1f14:824:300::/56","35.155.178.254/32","52.204.96.37/32","2406:da18:809:e00::/56","35.160.177.10/32","52.203.14.55/32","18.184.99.128/25","2401:1d80:3000::/36","52.215.192.128/25","104.192.136.0/21","18.205.93.0/27","35.171.175.212/32","18.136.214.0/25","52.202.195.162/32","13.52.5.0/25","34.218.168.212/32","18.234.32.128/25","34.218.156.209/32","52.54.90.98/32","34.232.119.183/32","34.232.25.90/32","8.8.4.0/24","8.8.8.0/24","8.34.208.0/20","8.35.192.0/20","23.236.48.0/20","23.251.128.0/19","34.64.0.0/10","34.128.0.0/10","35.184.0.0/13","35.192.0.0/14","35.196.0.0/15","35.198.0.0/16","35.199.0.0/17","35.199.128.0/18","35.200.0.0/13","35.208.0.0/12","35.224.0.0/12","35.240.0.0/13","64.15.112.0/20","64.233.160.0/19","66.102.0.0/20","66.249.64.0/19","70.32.128.0/19","72.14.192.0/18","74.114.24.0/21","74.125.0.0/16","104.154.0.0/15","104.196.0.0/14","104.237.160.0/19","107.167.160.0/19","107.178.192.0/18","108.59.80.0/20","108.170.192.0/18","108.177.0.0/17","130.211.0.0/16","136.112.0.0/12","142.250.0.0/15","146.148.0.0/17","162.216.148.0/22","162.222.176.0/21","172.110.32.0/21","172.217.0.0/16","172.253.0.0/16","173.194.0.0/16","173.255.112.0/20","192.158.28.0/22","192.178.0.0/15","193.186.4.0/24","199.36.154.0/23","199.36.156.0/24","199.192.112.0/22","199.223.232.0/21","207.223.160.0/20","208.65.152.0/22","208.68.108.0/22","208.81.188.0/22","208.117.224.0/19","209.85.128.0/17","216.58.192.0/19","216.73.80.0/20","216.239.32.0/19","2001:4860::/32","2404:6800::/32","2404:f340::/32","2600:1900::/28","2607:f8b0::/32","2620:11a:a000::/40","2620:120:e000::/40","2800:3f0::/32","2a00:1450::/32","2c0f:fb50::/32"]` | (list) CIDR ranges to permit for egress |
| networkPolicy.egress.enabled | bool | `true` | (boolean) If the NetworkPolicy should be enabled for egress |
| networkPolicy.egress.portAllowList | list | `[{"port":443,"protocol":"TCP"}]` | (list) Posts/protocols to permit for egress |
| networkPolicy.ingress.cidrAllowList | list | `nil` | CIDR ranges to permit for ingress |
| networkPolicy.ingress.enabled | bool | `true` | (boolean) If the NetworkPolicy should be enabled for ingress |
| networkPolicy.ingress.portAllowList | list | `nil` | Posts/protocols to permit for ingress |
| probes.liveness.enabled | bool | `false` | (boolean) If the liveness probe should be enabled |
| probes.liveness.spec | object | `nil` | Spec for the liveness probe |
| probes.readiness.enabled | bool | `false` | (boolean) If the readiness probe should be enabled |
| probes.readiness.spec | object | `nil` | Spec for the readiness probe |
| probes.startup.enabled | bool | `false` | (boolean) If the startup probe should be enabled |
| probes.startup.spec | object | `nil` | Spec for the startup probe |
| replicas | int | `3` | (number) Number of replicas for the deployment |
| resources.limits.cpu | string | `"500m"` | (string) Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"4Gi"` | (string) Memory to limit the deployment to |
| resources.requests.cpu | string | `"500m"` | (string) Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"4Gi"` | (string) Memory to request for the deployment |
| secrets.gcpServiceAccount.secretsManager.enabled | bool | `false` | (boolean) If secretsManager should be used for the GCP SA |
| secrets.gcpServiceAccount.secretsManager.sourceEncoding | string | `"base64"` | (string) Encoding of the Vault field (either `text` or `base64`) |
| secrets.gcpServiceAccount.secretsManager.vaultKey | string | `nil` | Field name within the secret for the SA's key |
| secrets.gcpServiceAccount.secretsManager.vaultPath | string | `nil` | Path within Vault where the SA's key is stored |
| secrets.gcpServiceAccount.workloadIdentity.accountName | string | `nil` | ID of the GCP SA to use |
| secrets.gcpServiceAccount.workloadIdentity.enabled | bool | `false` | (boolean) If workloadIdentity should be used for the GCP SA |
| secrets.gcpServiceAccount.workloadIdentity.projectId | string | `nil` | ID (not the number) of the GCP project the SA is in |
| secrets.statuspageApiKey.secretsManager.enabled | bool | `false` | (boolean) If secretsManager should be used for the API key |
| secrets.statuspageApiKey.secretsManager.sourceEncoding | string | `"text"` | (string) Encoding of the Vault field (either `text` or `base64`) |
| secrets.statuspageApiKey.secretsManager.vaultKey | string | `nil` | Field name within the secret for the API key |
| secrets.statuspageApiKey.secretsManager.vaultPath | string | `nil` | Path within Vault where the API key is stored |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
