terra-filebeat
==============
Chart for shipping logs to logit.io via filebeat in terra k8s clusters

Current chart version is `0.0.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| beatsPort | string | `nil` | Required. Port on the logit ELK stack to export logs to. Should be the beats-ssl port |
| environmentName | string | `nil` | Required. Name of the environment ie dev, perf, ... Used to determine which namespace to export logs from |
| image | string | `"docker.elastic.co/beats/filebeat-oss"` | (string) filebeat image to use |
| imageTag | string | `"7.6.2"` | (string) specify filebeat image version |
| podSecurityPolicy | string | `"terra-default-psp"` | (string) Psp to associate with the filebeat service account |
