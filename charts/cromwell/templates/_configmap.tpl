{{- /* Generate a configmap for a Cromwell deployment */ -}}
{{- define "cromwell.configmap" -}}
{{- $settings := ._deploymentSettings -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $settings.name }}-cm
  labels:
{{ include "cromwell.labels" . | indent 4 }}
data:
  logback.xml: |
{{ include "cromwell.config.logback" . | indent 4 }}
{{ end -}}
