# dsp-grafana

![Version: 1.2.0](https://img.shields.io/badge/Version-1.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Wrapper providing GKE ingress, CloudSQL sidecar, and secrets around Grafana

To update the version of Grafana used by this chart, set `grafana.image.tag` in the chart values.

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>
* <https://github.com/grafana/helm-charts/tree/main/charts/grafana>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://terra-helm-thirdparty.storage.googleapis.com/ | grafana | 6.17.7 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| githubTeamSync.enabled | bool | `false` | If broadinstitute/grafana-github-team-sync should be run as a cronjob |
| githubTeamSync.grafanaHost | string | `"dsp-grafana.grafana"` | FQDN of the Grafana to target |
| githubTeamSync.grafanaPort | int | `80` | Optional port to use to communicate with grafanaHost |
| githubTeamSync.grafanaProtocol | string | `"http"` | Protocol to use to communicate with grafanaHost |
| githubTeamSync.image | string | `"us-central1-docker.pkg.dev/dsp-artifact-registry/grafana-github-team-sync/grafana-github-team-sync:edge"` | Image to use for the cronjob, pulled each time |
| githubTeamSync.neverRemovePermissionsFrom | string | `"admin"` | Comma separated list of exact usernames to never remove permissions from |
| githubTeamSync.schedule | string | `"0 14 * * *"` | The schedule to run the job on (14:00 UTC == 2:00PM UTC == 9:00AM ET, after BITS GitHub sync from 6-9am) https://broadinstitute.slack.com/archives/C4P1S6KB8/p1628173022001400?thread_ts=1628172949.001300&cid=C4P1S6KB8 |
| githubTeamSync.targetGrafanaOrgId | int | `1` | The numeric ID of the Grafana org to target |
| githubTeamSync.teamGrantingGrafanaAdmin | string | `nil` | A specific team to also be granted admin, like `broadinstitute/dsp-devops. Can be set to empty to have none. |
| githubTeamSync.timeoutSeconds | int | `900` | Timeout for the cronjob |
| global.name | string | `"grafana"` |  |
| grafana | object | `{"admin":{"existingSecret":"grafana-admin-account"},"command":["/bin/sh","-c","sleep 5; /run.sh"],"envFromSecret":"{{ .Values.global.name }}-container-env","extraContainers":"- name: cloudsql-proxy\n  image: gcr.io/cloudsql-docker/gce-proxy:1.27.0\n  envFrom:\n    - secretRef:\n        name: {{ .Values.global.name }}-sqlproxy-env\n  command: \n    - \"/cloud_sql_proxy\"\n    - \"-instances=$(SQL_INSTANCE_PROJECT):$(SQL_INSTANCE_REGION):$(SQL_INSTANCE_NAME)=tcp:5432\"","fullnameOverride":"dsp-grafana","grafana.ini":{"database":{"host":"localhost:5432","ssl_mode":"disable","type":"postgres"}},"imageRenderer":{"revisionHistoryLimit":0},"ingress":{"enabled":false},"replicas":3,"revisionHistoryLimit":0,"service":{"annotations":{"cloud.google.com/app-protocols":"{\"service\":\"HTTP\"}","cloud.google.com/backend-config":"{\"default\": \"grafana-ingress-backendconfig\"}","cloud.google.com/neg":"{\"ingress\": true}"},"port":80},"serviceAccount":{"name":"grafana-sa"},"sidecar":{"dashboards":{"enabled":false,"provider":{"foldersFromFilesStructure":true},"searchNamespace":null}}}` | Settings for Grafana subchart, use grafana.image.tag to override the subchart's default Grafana version |
| grafana."grafana.ini".database | object | `{"host":"localhost:5432","ssl_mode":"disable","type":"postgres"}` | Leave most config to the env but do set fields relating to the CloudSQL requirements |
| grafana.admin.existingSecret | string | `"grafana-admin-account"` | Derive the admin account credentials from a secret (created by secrets.AdminAccount) |
| grafana.command | list | `["/bin/sh","-c","sleep 5; /run.sh"]` | Make Grafana briefly sleep before starting to let the CloudSQL proxy come online |
| grafana.envFromSecret | string | `"{{ .Values.global.name }}-container-env"` | Reference the wrapper's secret to add to the grafana environment |
| grafana.extraContainers | string | `"- name: cloudsql-proxy\n  image: gcr.io/cloudsql-docker/gce-proxy:1.27.0\n  envFrom:\n    - secretRef:\n        name: {{ .Values.global.name }}-sqlproxy-env\n  command: \n    - \"/cloud_sql_proxy\"\n    - \"-instances=$(SQL_INSTANCE_PROJECT):$(SQL_INSTANCE_REGION):$(SQL_INSTANCE_NAME)=tcp:5432\""` | Include the cloud SQL proxy as a sidecar |
| grafana.fullnameOverride | string | `"dsp-grafana"` | Override the name used for the deployment and other resources (it gets interpolated to this otherwise but we want to reference it) |
| grafana.imageRenderer.revisionHistoryLimit | int | `0` | Replicaset revisions not saved since we'd rollback via gitops or argo |
| grafana.ingress.enabled | bool | `false` | DISABLE grafana's built-in ingress |
| grafana.replicas | int | `3` | Bump the default replicas since the wrapper's database persistence allows it |
| grafana.revisionHistoryLimit | int | `0` | Replicaset revisions not saved since we'd rollback via gitops or argo |
| grafana.service.port | int | `80` | Port to run the (non-HTTPS) service over |
| grafana.serviceAccount.name | string | `"grafana-sa"` | Set the SA name specifically so cronjobs can use it |
| grafana.sidecar.dashboards.enabled | bool | `false` | Dashboards from configmaps disabled by default |
| grafana.sidecar.dashboards.provider.foldersFromFilesStructure | bool | `true` | Respect filesystem structure derived from the configmap annotations |
| grafana.sidecar.dashboards.searchNamespace | list | `nil` | Namespaces to look for configmaps in; if empty, use the release namespace Note: 'all' is theoretically supported here but not by `.Values.sidecarFacilitation` Note: empty causes `.Values.sidecarFacilitation` to have no effect |
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
| secrets.databaseInstance | object | `{"nameSourceEncoding":"text","nameVaultKey":"name","projectSourceEncoding":"text","projectVaultKey":"project","regionSourceEncoding":"text","regionVaultKey":"region","vaultPath":null}` | A secret containing database cert files to use for Grafana's persistence |
| secrets.databaseInstance.nameSourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.databaseInstance.nameVaultKey | string | `"name"` | (string) Key within the desired Vault secret to the desired individual secret value to use |
| secrets.databaseInstance.projectSourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.databaseInstance.projectVaultKey | string | `"project"` | (string) Key within the desired Vault secret to the desired individual secret value to use |
| secrets.databaseInstance.regionSourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.databaseInstance.regionVaultKey | string | `"region"` | (string) Key within the desired Vault secret to the desired individual secret value to use |
| secrets.databaseInstance.vaultPath | string | `nil` | Path within Vault to the desired Vault secret |
| secrets.githubTeamSync.githubTokenSourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.githubTeamSync.githubTokenVaultKey | string | `"token"` | (string) Key within the desired Vault secret to the desired individual secret value to use |
| secrets.githubTeamSync.githubTokenVaultPath | string | `nil` | Path within Vault to the desired Vault secret |
| secrets.githubTeamSync.grafanaAuthPasswordSourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.githubTeamSync.grafanaAuthPasswordVaultKey | string | `"password"` | (string) Key within the desired Vault secret to the desired individual secret value to use |
| secrets.githubTeamSync.grafanaAuthUsernameSourceEncoding | string | `"text"` | (string) Encoding of the secret value in vault (either `text` or `base64`) |
| secrets.githubTeamSync.grafanaAuthUsernameVaultKey | string | `"username"` | (string) Key within the desired Vault secret to the desired individual secret value to use |
| secrets.githubTeamSync.grafanaAuthVaultPath | string | `nil` | Path within Vault to the desired Vault secret |
| sidecarFacilitation | object | `{"allowGrantedUsersToRestart":true,"createSearchedNamespaces":false,"grantUsersNamespaceAccess":[]}` | Options supporting the use of the Grafana sidecar for importing JSON from K8s if the sidecar targets non-release namespaces |
| sidecarFacilitation.allowGrantedUsersToRestart | bool | `true` | Allow any users with namespace access to also rollout a grafana restart |
| sidecarFacilitation.createSearchedNamespaces | bool | `false` | If this chart should create namespaces the sidecar intends to search |
| sidecarFacilitation.grantUsersNamespaceAccess | list | `[]` | A list of users (can be GCP SA emails) to grant narrow access to the namespaces |

