{{- /* Generate the data component of a rawls config map */ -}}
{{- define "rawls.configmap.data" -}}
data:
  prometheusJmx.yaml: |
{{ include "rawls.config.prometheusJmx" . | indent 4 }}
{{- end -}}

{{- /* Generate a configmap for a rawls deployment */ -}}
{{- define "rawls.configmap" -}}
{{- $settings := ._deploymentSettings -}}

{{- $data := include "rawls.configmap.data" . -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $settings.name }}-cm
  labels:
{{ include "rawls.labels" . | indent 4 }}
{{ $data }}
{{ end -}}