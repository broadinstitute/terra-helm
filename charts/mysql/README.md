# mongodb

A Helm Chart for Mysql
This chart is customized for Terra preview environments

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| databaseName | string | `nil` | name of a default database that the service expects (if any) i.e. a new leonardo instance expects a 'leonardo' database to already exist |
| global.applicationVersion | string | `"latest"` | What version of mysql to deploy |
| global.storageClass | string | `"standard"` | Storage class to use when provisioning persistent disks |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"mysql"` | Image repository |
| imageConfig.tag | string | `nil` | Image tag. |
| name | string | `"mysql"` | A name for the statefulset that will be substituted into resource definitions |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.exec.command[0] | string | `"mysqladmin"` |  |
| probes.liveness.spec.exec.command[1] | string | `"ping"` |  |
| probes.liveness.spec.failureThreshold | int | `6` |  |
| probes.liveness.spec.initialDelaySeconds | int | `30` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.successThreshold | int | `1` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.exec.command[0] | string | `"bash"` |  |
| probes.readiness.spec.exec.command[1] | string | `"-c"` |  |
| probes.readiness.spec.exec.command[2] | string | `"mysql -h 127.0.0.1 -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e \"SELECT 1\""` |  |
| probes.readiness.spec.failureThreshold | int | `30` |  |
| probes.readiness.spec.initialDelaySeconds | int | `5` |  |
| probes.readiness.spec.periodSeconds | int | `2` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `1` |  |
| replicas | int | `1` |  |
| resources.limits.cpu | int | `1` | Number of CPU units to limit the statefulset to |
| resources.limits.memory | string | `"1Gi"` | Memory to limit the statefulset to |
| resources.requests.cpu | int | `1` | Number of CPU units to request for the statefulset |
| resources.requests.memory | string | `"1Gi"` | Memory to request for the statefulset |
| serviceName | string | `nil` | name of the terra service for which this mysql is for, i.e. leonardo. required, no default |
| vault.dbPasswordKey | string | `"db_password"` |  |
| vault.dbUsernameKey | string | `"db_user"` |  |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
