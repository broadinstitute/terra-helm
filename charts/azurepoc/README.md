# azurepoc

Chart for azurepoc service in Terra

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>
* <https://github.com/databiosphere/azurepoc>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.applicationVersion | string | `"latest"` |  |
| imageRepository | string | `"gcr.io/terra-kernel-k8s/azurepoc"` |  |
| imageTag | string | `nil` |  |
| name | string | `"azurepoc"` | name of the application to template into k8s resources |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/status"` |  |
| probes.liveness.spec.httpGet.port | int | `8000` |  |
| probes.liveness.spec.initialDelaySeconds | int | `15` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.successThreshold | int | `1` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `6` |  |
| probes.readiness.spec.httpGet.path | string | `"/status"` |  |
| probes.readiness.spec.httpGet.port | int | `8000` |  |
| probes.readiness.spec.initialDelaySeconds | int | `15` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `5` |  |
| probes.startup.enabled | bool | `false` |  |
| probes.startup.spec.failureThreshold | int | `1080` |  |
| probes.startup.spec.httpGet.path | string | `"/status"` |  |
| probes.startup.spec.httpGet.port | int | `8000` |  |
| probes.startup.spec.periodSeconds | int | `10` |  |
| probes.startup.spec.successThreshold | int | `1` |  |
| probes.startup.spec.timeoutSeconds | int | `5` |  |
| replicas | int | `3` | number of app replicas to run |
| resources.limits.cpu | int | `1` | Number of CPU units to limit the deployment to |
| resources.limits.memory | string | `"4Gi"` | Memory to limit the deployment to |
| resources.requests.cpu | int | `1` | Number of CPU units to request for the deployment |
| resources.requests.memory | string | `"4Gi"` | Memory to request for the deployment |
