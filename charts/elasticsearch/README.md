# elasticsearch

![Version: 0.12.0](https://img.shields.io/badge/Version-0.12.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

a helm chart to deploy monitoring infrastructure

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Michael Flinn | mflinn@broadinstitute.org |  |

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://helm.elastic.co | elasticsearch | 6.8.13 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backup.enabled | bool | `false` | Whether to run nightly snapshots of the ES cluster backed up to GCS |
| backup.hostname | string | `nil` | hostname of the elasticsearch server the backup job will snapshot |
| backup.imageRepo | string | `"us-central1-docker.pkg.dev/dsp-artifact-registry/elasticsearch-backup/elasticsearch-backup"` | specify an image repository for the backup job |
| backup.imageTag | string | `"1.0.0"` | specify a tag for the image running the backup job |
| backup.nodeSelector | object | `{}` | NodeSelector for backup Cronjob pods |
| backup.snapshotRpository | string | `nil` |  |
| backup.timeoutSeconds | int | `7200` | amount of time after which job automatically fails |
| backup.tolerations | list | `[]` | Tolerations for backup Cronjob pods |
| elasticsearch.clusterName | string | `"elasticsearch5a"` |  |
| elasticsearch.esConfig."elasticsearch.yml" | string | `"http:\n  cors:\n    enabled: true\n    allow-origin: '*'\nxpack:\n  graph:\n    enabled: false\n  ml:\n    enabled: false\n  monitoring:\n    enabled: false\n  security:\n    enabled: false\n  watcher:\n    enabled: false\n"` |  |
| elasticsearch.esJavaOpts | string | `"-Xms3500m -Xmx3500m"` |  |
| elasticsearch.extraVolumeMounts[0].mountPath | string | `"/usr/share/elasticsearch/config/snapshot_credentials.json"` |  |
| elasticsearch.extraVolumeMounts[0].name | string | `"snapshot-sa"` |  |
| elasticsearch.extraVolumeMounts[0].readOnly | bool | `true` |  |
| elasticsearch.extraVolumeMounts[0].subPath | string | `"snapshot_credentials.json"` |  |
| elasticsearch.extraVolumes[0].name | string | `"snapshot-sa"` |  |
| elasticsearch.extraVolumes[0].secret.secretName | string | `"elasticsearch-gcs-sa"` |  |
| elasticsearch.image | string | `"docker.io/broadinstitute/elasticsearch"` |  |
| elasticsearch.imageTag | string | `"5.4.0_6"` |  |
| elasticsearch.nodeSelector."bio.terra/node-pool" | string | `"elasticsearch"` |  |
| elasticsearch.persistence.annotations."bio.terra/snapshot-policy" | string | `"terra-snapshot-policy"` |  |
| elasticsearch.podSecurityPolicy.create | bool | `true` |  |
| elasticsearch.podSecurityPolicy.spec.fsGroup.rule | string | `"RunAsAny"` |  |
| elasticsearch.podSecurityPolicy.spec.privileged | bool | `true` |  |
| elasticsearch.podSecurityPolicy.spec.runAsUser.rule | string | `"RunAsAny"` |  |
| elasticsearch.podSecurityPolicy.spec.seLinux.rule | string | `"RunAsAny"` |  |
| elasticsearch.podSecurityPolicy.spec.supplementalGroups.rule | string | `"RunAsAny"` |  |
| elasticsearch.podSecurityPolicy.spec.volumes[0] | string | `"secret"` |  |
| elasticsearch.podSecurityPolicy.spec.volumes[1] | string | `"configMap"` |  |
| elasticsearch.podSecurityPolicy.spec.volumes[2] | string | `"persistentVolumeClaim"` |  |
| elasticsearch.podSecurityPolicy.spec.volumes[3] | string | `"emptyDir"` |  |
| elasticsearch.rbac.create | bool | `true` |  |
| elasticsearch.resources.limits.cpu | int | `2` |  |
| elasticsearch.resources.limits.memory | string | `"8Gi"` |  |
| elasticsearch.resources.requests.cpu | int | `2` |  |
| elasticsearch.resources.requests.memory | string | `"8Gi"` |  |
| elasticsearch.service.loadBalancerIP | string | `nil` |  |
| elasticsearch.service.loadBalancerSourceRanges | list | `[]` |  |
| elasticsearch.service.type | string | `"LoadBalancer"` |  |
| elasticsearch.tolerations[0].effect | string | `"NoSchedule"` |  |
| elasticsearch.tolerations[0].key | string | `"bio.terra/workload"` |  |
| elasticsearch.tolerations[0].operator | string | `"Equal"` |  |
| elasticsearch.tolerations[0].value | string | `"elasticsearch"` |  |
| elasticsearch.volumeClaimTemplate.accessModes[0] | string | `"ReadWriteOnce"` |  |
| elasticsearch.volumeClaimTemplate.resources.requests.storage | string | `"200Gi"` |  |
| elasticsearch.volumeClaimTemplate.storageClassName | string | `"terra-ssd-zonal"` |  |
| expose | bool | `false` | If true will create a loadbalancer service for each pod, enables using the transport client from outside the cluster |
| exposeIPs | list | `[]` | List of ips to associate with each ES pod |
| global.name | string | `"elasticsearch"` | A name for the deployment that will be substituted into resource definitions |
| replicaCount | int | `3` | number of elasticsearch replicas to expose. |
| vault.pathPrefix | string | `nil` | path where elasticsearch secrets are stored in vault |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
