# azurepoc

Chart for azurepoc service in Terra

### This is a chart to deploy a poc hello world application to an AKS cluster.

### This chart is for POC and demonstration purposes only and not intended for production use

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>
* <https://github.com/databiosphere/azurepoc>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.applicationVersion | string | `"latest"` |  |
| imagePullSecret | string | `nil` | name of k8s secret containing credentials to authenticate to a private image repo |
| imageRepository | string | `"gcr.io/terra-kernel-k8s/azurepoc"` | url for repo hosting the image deployed in this chart |
| imageTag | string | `nil` |  |
| ingress.enabled | bool | `true` | (bool) whether to provision an ingress and expose this application to traffic from outside the cluster |
| ingress.hostName | string | `"azurepoc.mflinn.azure.dev.envs-terra.bio"` | hostname for this application. Used for host based routing in the ingress |
| ingress.tlsIssuer | string | `"letsencrypt-prod-issuer"` | when multiple CAs are configured for a cluster can be used to select a specfic one |
| ingress.tlsSecretName | string | `"tls-secret"` | name of the k8s secret the tls cert will be stored in |
| name | string | `"azurepoc"` | name of the application to template into k8s resources |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/status"` |  |
| probes.liveness.spec.httpGet.port | int | `8080` |  |
| probes.liveness.spec.initialDelaySeconds | int | `15` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.successThreshold | int | `1` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `6` |  |
| probes.readiness.spec.httpGet.path | string | `"/status"` |  |
| probes.readiness.spec.httpGet.port | int | `8080` |  |
| probes.readiness.spec.initialDelaySeconds | int | `15` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `5` |  |
| probes.startup.enabled | bool | `false` |  |
| probes.startup.spec.failureThreshold | int | `1080` |  |
| probes.startup.spec.httpGet.path | string | `"/status"` |  |
| probes.startup.spec.httpGet.port | int | `8080` |  |
| probes.startup.spec.periodSeconds | int | `10` |  |
| probes.startup.spec.successThreshold | int | `1` |  |
| probes.startup.spec.timeoutSeconds | int | `5` |  |
| replicas | int | `3` | number of app replicas to run |
| resources.limits.cpu | int | `1` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"4Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `1` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"4Gi"` | Memory to request for the deployment |
