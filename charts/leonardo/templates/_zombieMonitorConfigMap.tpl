{{- /* Generate the data component of a Cromwell config map */ -}}
{{- define "zombie-monitor.configmap.data" -}}
data:
  application.conf: |
{{ include "zombie-monitor.config.zombieMonitor" . | indent 4 }}
{{- end -}}

{{- /* Generate a configmap for a zombie-monitor deployment */ -}}
{{- define "zombie-monitor.configmap" -}}
{{- $settings := ._deploymentSettings -}}

{{- /*
  Render ConfigMap data, then checksum it, and store the checksum
  in the deploymentOutputs dictionary so that it be included as an annotation
  on the deployment's pod template. (see _deployment.tpl)

  This is used to automatically restart zombie-monitor pods when the ConfigMap
  changes.
*/ -}}
{{- $data := include "zombie-monitor.configmap.data" . -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: zombie-monitor-cm
  labels: {}
{{ $data }}
{{ end -}}
