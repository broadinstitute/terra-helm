# terra-filebeat

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Chart for shipping logs to logit.io via filebeat in terra k8s clusters

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| beatsPort | string | `nil` | Required. Port on the logit ELK stack to export logs to. Should be the beats-ssl port |
| environmentName | string | `nil` | Required. Name of the environment ie dev, perf, ... Used to determine which namespace to export logs from |
| ignore | list | `[]` | (list) Optional. A list of application names which filebeat will ignore logs from. used to selectively disable log forwarding for particular services. |
| image | string | `"docker.elastic.co/beats/filebeat-oss"` | (string) filebeat image to use |
| imageTag | string | `"7.6.2"` | (string) specify filebeat image version |
| podSecurityPolicy | string | `"terra-default-psp"` | (string) Psp to associate with the filebeat service account |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.4.0](https://github.com/norwoodj/helm-docs/releases/v1.4.0)