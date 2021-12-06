# trdash

![Version: 0.12.0](https://img.shields.io/badge/Version-0.12.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Chart for TestRunner Dashbaord

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>
* <https://github.com/DataBiosphere/terra-test-runner-dashboard>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://broadinstitute.github.io/terra-helm/ | ingresslib | 0.12.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| annotations | object | `{}` | (map) Annotations for application pods |
| config | object | `nil` | Required; contents of testrunnerdashboard.yaml to be given to the application |
| createReleaseNamespace | bool | `false` | Emulate current Helm3 chart functionality, i.e., do not create the release namespace by default |
| global.applicationVersion | string | `"latest"` | (string) What version of the application to deploy |
| global.name | string | `"trdash"` | A name for the deployment that will be substituted into resource definitions |
| imageConfig.imagePullPolicy | string | `"Always"` | (string) When to pull images |
| imageConfig.repository | string | `"us-central1-docker.pkg.dev/dsp-artifact-registry/terra-test-runner-dashboard/terra-test-runner-dashboard"` | (string) Image repository |
| imageConfig.tag | string | `nil` | Image tag |
| ingress.cert.certManager.duration | string | `"2160h0m0s"` | Certificate duration. Defaults to 3 months. |
| ingress.cert.certManager.enabled | bool | `false` | Enable creating certificate secret with cert-manager |
| ingress.cert.certManager.issuerKind | string | `"ClusterIssuer"` |  |
| ingress.cert.certManager.issuerName | string | `"cert-manager-letsencrypt-prod"` |  |
| ingress.cert.certManager.renewBefore | string | `"720h0m0s"` | When to renew the cert. Defaults to 30 days before expiry. |
| ingress.cert.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.cert.vault.cert.path | string | `nil` | Path to secret containing .crt |
| ingress.cert.vault.cert.secretKey | string | `nil` | Key in secret containing .crt |
| ingress.cert.vault.chain.path | string | `nil` | Path to secret containing intermediate .crt |
| ingress.cert.vault.chain.secretKey | string | `nil` | Key in secret containing intermediate .crt |
| ingress.cert.vault.enabled | bool | `true` | Enable syncing certificate secret from Vault. Requires [secrets-manager](https://github.com/tuenti/secrets-manager) |
| ingress.cert.vault.key.path | string | `nil` | Path to secret containing .key |
| ingress.cert.vault.key.secretKey | string | `nil` | Key in secret containing .key |
| ingress.deployment | string | `"trdash"` | Name of the deployment to associate with the Ingress (should correspond to the "name" key, above) |
| ingress.domain.hostname | string | `"trdash"` |  |
| ingress.domain.namespaceEnv | bool | `false` |  |
| ingress.domain.suffix | string | `"dsp-eng-tools.broadinstitute.org"` |  |
| ingress.enabled | bool | `true` | Whether to create Ingress, Service and associated config resources |
| ingress.requestPath | string | `"/"` | Request path to which the probe system should connect |
| ingress.securityPolicy | string | `""` | (string) Name of a GCP Cloud Armor security policy |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` |  |
| probes.liveness.enabled | bool | `false` | (boolean) If the liveness probe should be enabled |
| probes.liveness.spec | object | `nil` | Spec for the liveness probe |
| probes.readiness.enabled | bool | `false` | (boolean) If the readiness probe should be enabled |
| probes.readiness.spec | object | `nil` | Spec for the readiness probe |
| probes.startup.enabled | bool | `false` | (boolean) If the liveness probe should be enabled |
| probes.startup.spec | object | `nil` | Spec for the startUp probe |
| replicas | int | `3` | (number) Number of replicas for the deployment |
| resources.limits.cpu | int | `4` | (string) Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"8Gi"` | (string) Memory to limit the deployment to |
| resources.requests.cpu | int | `4` | (string) Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"8Gi"` | (string) Memory to request for the deployment |
| secrets.gcpServiceAccount.secretsManager.enabled | bool | `false` | (boolean) If secrets-manager (Vault) should be used for the GCP SA |
| secrets.gcpServiceAccount.secretsManager.sourceEncoding | string | `"base64"` | (string) Encoding of the Vault field (either `text` or `base64`) |
| secrets.gcpServiceAccount.secretsManager.vaultKey | string | `nil` | Field name within the secret for the SA's key |
| secrets.gcpServiceAccount.secretsManager.vaultPath | string | `nil` | Path within Vault where the SA's key is stored |
| secrets.gcpServiceAccount.workloadIdentity.accountName | string | `nil` | ID of the GCP SA to use |
| secrets.gcpServiceAccount.workloadIdentity.enabled | bool | `true` | (boolean) If workload identity should be used for the GCP SA |
| secrets.gcpServiceAccount.workloadIdentity.projectId | string | `nil` | ID (not the number) of the GCP project the SA is in |
| secrets.gcpServiceAccount.workloadIdentity.useConfigConnect | bool | `false` | (boolean) If Config Connector should be used for provisioning the workload identity SA -- If false, the workload identity SA will be provisioned by other means |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
