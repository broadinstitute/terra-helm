{{- /* Generate the data component of a resource-validator config map */ -}}
{{- define "resource-validator.configmap.data" -}}
data:
  application.conf: |
{{ include "cronjobs.config.resourceValidator" . | indent 4 }}  
{{- end -}}

{{- /* Generate a configmap for a resource-validator cron job */ -}}
{{- define "resource-validator.configmap" -}}
{{- $settings := ._deploymentSettings -}}

{{- $data := include "resource-validator.configmap.data" . -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: resource-validator-cm
  labels: {}
{{ $data }}
{{ end -}}
