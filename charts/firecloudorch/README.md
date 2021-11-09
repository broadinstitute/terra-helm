# firecloudorch

![Version: 0.13.0](https://img.shields.io/badge/Version-0.13.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

Chart for firecloud-orchestration service in Terra

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>
* <https://github.com/broadinstitute/firecloud-orchestration>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://terra-helm.storage.googleapis.com | pdb-lib | 0.4.0 |
| https://terra-helm.storage.googleapis.com | sherlock-reporter | 0.3.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| elasticsearch.transportProbe.appHostname | string | `"localhost:8080"` | hostname used for querying orch's status |
| elasticsearch.transportProbe.elasticHostname | string | `"elasticsearch5a-master-0.elasticsearch5a-master-headless:9200"` | hostname for querying the status of the Elasticsearch cluster |
| elasticsearch.transportProbe.enabled | bool | `true` | Enables a custom liveness probe to account for ES transport client losing connection when elasticsearch restarts. |
| elasticsearch.transportProbe.initContainerImage | string | `"alpine:3.12.0"` | Docker image to use to install tools needed for custom probe |
| elasticsearch.transportProbe.spec | object | `{"exec":{"command":["./etc/probe/probe.sh"]},"failureThreshold":3,"initialDelaySeconds":20,"periodSeconds":90,"successThreshold":1,"timeoutSeconds":5}` | Spec for the custom liveness probe |
| elasticsearch.transportProbe.timeout | int | `10` | timeout in seconds for probe requests |
| global.applicationVersion | string | `"latest"` | What version of the Cromwell application to deploy |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"gcr.io/broad-dsp-gcr-public/firecloud-orchestration"` | Image repository |
| imageConfig.tag | string | global.applicationVersion | Image tag. |
| ingress.cert.preSharedCerts | list | `[]` | Array of pre-shared GCP SSL certificate names to associate with the Ingress |
| ingress.cert.vault.cert.path | string | `nil` | Path to secret containing .crt |
| ingress.cert.vault.cert.secretKey | string | `nil` | Key in secret containing .crt |
| ingress.cert.vault.enabled | bool | `false` |  |
| ingress.cert.vault.key.path | string | `nil` | Path to secret containing .key |
| ingress.cert.vault.key.secretKey | string | `nil` | Key in secret containing .key |
| ingress.enabled | bool | `true` | Whether to create Ingress, Service and associated config resources |
| ingress.sslPolicy | string | `nil` | Name of a GCP SSL policy to associate with the Ingress |
| ingress.staticIpName | string | `nil` | Required. Name of the static IP, allocated in GCP, to associate with the Ingress |
| ingress.timeoutSec | int | `120` |  |
| name | string | `"firecloudorch"` |  |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/version"` |  |
| probes.liveness.spec.httpGet.port | int | `8080` |  |
| probes.liveness.spec.initialDelaySeconds | int | `20` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.successThreshold | int | `1` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `6` |  |
| probes.readiness.spec.httpGet.path | string | `"/status"` |  |
| probes.readiness.spec.httpGet.port | int | `8080` |  |
| probes.readiness.spec.initialDelaySeconds | int | `20` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `5` |  |
| prometheus.enabled | bool | `true` |  |
| prometheus.initContainerImage | string | `"alpine:3.12.0"` |  |
| prometheus.jmxJarRepo | string | `"https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent"` |  |
| prometheus.jmxJarVersion | string | `"0.13.0"` |  |
| proxyImage | string | `"broadinstitute/openidc-proxy:tcell_3_1_0"` |  |
| replicas | int | `0` |  |
| resources.limits.cpu | int | `2` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"8Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `2` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"8Gi"` | Memory to request for the deployment |
| sherlock.appImageName | string | `"gcr.io/broad-dsp-gcr-public/firecloud-orchestration"` |  |
| sherlock.appName | string | `"firecloudorch"` |  |
| sherlock.enabled | bool | `true` |  |
| sherlock.sherlockImageTag | string | `"v0.0.15"` |  |
| sherlock.vault.pathPrefix | string | `"secret/suitable/sherlock/prod"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
