{{- /* Generate the data component of a Cromwell config map */ -}}
{{- define "zombie-monitor.configmap.data" -}}
data:
  application.conf: |
{{ include "cronjobs.config.zombieMonitor" . | indent 4 }}
{{- end -}}

{{- /* Generate a configmap for a zombie-monitor deployment */ -}}
{{- define "zombie-monitor.configmap" -}}
{{- $settings := ._deploymentSettings -}}

{{- $data := include "zombie-monitor.configmap.data" . -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: zombie-monitor-cm
  labels: {}
{{ $data }}
{{ end -}}
