# dsp-grafana

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Wrapper providing GKE ingress and DSP secrets around grafana

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>
* <https://github.com/grafana/helm-charts/tree/main/charts/grafana>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://terra-helm-thirdparty.storage.googleapis.com/ | grafana | 6.17.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.name | string | `"grafana"` |  |
| grafana."grafana.ini".database.ca_cert_path | string | `"/dbcerts/server-ca.pem"` |  |
| grafana."grafana.ini".database.client_cert_path | string | `"/dbcerts/client-cert.pem"` |  |
| grafana."grafana.ini".database.client_key_path | string | `"/dbcerts/client-key.pem"` |  |
| grafana."grafana.ini".database.server_cert_name | string | `"grafana-k8s"` |  |
| grafana.admin.existingSecret | string | `"grafana-admin-account"` | Derive the admin account credentials from a secret (created by secrets.AdminAccount) |
| grafana.envFromSecret | string | `"{{ .Values.global.name }}-container-env"` |  |
| grafana.extraEmptyDirMounts[0].mountPath | string | `"/dbcerts"` |  |
| grafana.extraEmptyDirMounts[0].name | string | `"permissioned-db-certs"` |  |
| grafana.extraInitContainers[0].args[0] | string | `"ls -la /dbcerts-ro; \ncp /dbcerts-ro/* /dbcerts;\nls -la /dbcerts;\nchmod 600 /dbcerts/*;\nls -la /dbcerts"` |  |
| grafana.extraInitContainers[0].command[0] | string | `"sh"` |  |
| grafana.extraInitContainers[0].command[1] | string | `"-c"` |  |
| grafana.extraInitContainers[0].image | string | `"alpine:3"` |  |
| grafana.extraInitContainers[0].name | string | `"adjust-cert-permissions"` |  |
| grafana.extraInitContainers[0].volumeMounts[0].mountPath | string | `"/dbcerts-ro"` |  |
| grafana.extraInitContainers[0].volumeMounts[0].name | string | `"readonly-raw-db-certs"` |  |
| grafana.extraInitContainers[0].volumeMounts[0].readOnly | bool | `true` |  |
| grafana.extraInitContainers[0].volumeMounts[1].mountPath | string | `"/dbcerts"` |  |
| grafana.extraInitContainers[0].volumeMounts[1].name | string | `"permissioned-db-certs"` |  |
| grafana.extraInitContainers[0].volumeMounts[1].readOnly | bool | `false` |  |
| grafana.extraSecretMounts[0].mountPath | string | `"/dbcerts-ro"` |  |
| grafana.extraSecretMounts[0].name | string | `"readonly-raw-db-certs"` |  |
| grafana.extraSecretMounts[0].readOnly | bool | `true` |  |
| grafana.extraSecretMounts[0].secretName | string | `"grafana-database-certs"` |  |
| grafana.ingress.enabled | bool | `false` | DISABLE grafana's built-in ingress |
| grafana.revisionHistoryLimit | int | `0` | Replicaset revisions not saved since we'd rollback via gitops or argo |
| grafana.service.annotations."cloud.google.com/app-protocols" | string | `"{\"service\":\"HTTP\"}"` |  |
| grafana.service.annotations."cloud.google.com/backend-config" | string | `"{\"default\": \"grafana-ingress-backendconfig\"}"` |  |
| grafana.service.annotations."cloud.google.com/neg" | string | `"{\"ingress\": true}"` |  |
| grafana.service.port | int | `80` | Port to run the (non-HTTPS) service over |
| ingress.cert.preSharedCerts | list | `[]` | Previously provisioned certs to use on the LB |
| ingress.certmanager.dnsNames | list | `[]` | FQDNs to allocate cert for |
| ingress.certmanager.enabled | bool | `true` | If CertManager should be used to dynamically provision an LB cert |
| ingress.enabled | bool | `true` | ENABLE this wrapper's simpler ingress config |
| ingress.requestPath | string | `"/api/health"` | Path to use for LB health checks |
| ingress.securityPolicy | string | `nil` | Optionally, the name of a cloud armor security policy to apply to the ingress backend |
| ingress.staticIpName | string | `nil` | Name of static IP previously allocated in the project |
| ingress.timeoutSec | int | `120` | Seconds before LB health check will time out |
| secrets.adminAccount | object | `{"passwordSourceEncoding":"text","passwordVaultKey":null,"usernameSourceEncoding":"text","usernameVaultKey":null,"vaultPath":null}` | A secret Grafana can use for its default Admin account |
| secrets.adminAccount.passwordSourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.adminAccount.passwordVaultKey | string | `nil` | Key within the desired Vault secret to the desired individual secret value to use |
| secrets.adminAccount.usernameSourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.adminAccount.usernameVaultKey | string | `nil` | Key within the desired Vault secret to the desired individual secret value to use |
| secrets.adminAccount.vaultPath | string | `nil` | Path within Vault to the desired Vault secret |
| secrets.containerEnv | list | `[{"envVar":null,"sourceEncoding":"text","vaultKey":null,"vaultPath":null}]` | (list) Secrets to be placed into environment variables in the grafana container |
| secrets.containerEnv[0].envVar | string | `nil` | Name of the environment variable to create |
| secrets.containerEnv[0].sourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.containerEnv[0].vaultKey | string | `nil` | Key within the desired Vault secret to the desired individual secret value to use |
| secrets.containerEnv[0].vaultPath | string | `nil` | Path within Vault to the desired Vault secret |
| secrets.databaseCerts | object | `{"clientCertSourceEncoding":"text","clientCertVaultKey":null,"clientKeySourceEncoding":"text","clientKeyVaultKey":null,"serverCaSourceEncoding":"text","serverCaVaultKey":null,"vaultPath":null}` | A secret containing database cert files to use for Grafana's persistence |
| secrets.databaseCerts.clientCertSourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.databaseCerts.clientCertVaultKey | string | `nil` | Key within the desired Vault secret to the desired individual secret value to use |
| secrets.databaseCerts.clientKeySourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.databaseCerts.clientKeyVaultKey | string | `nil` | Key within the desired Vault secret to the desired individual secret value to use |
| secrets.databaseCerts.serverCaSourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.databaseCerts.serverCaVaultKey | string | `nil` | Key within the desired Vault secret to the desired individual secret value to use |
| secrets.databaseCerts.vaultPath | string | `nil` | Path within Vault to the desired Vault secret |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
