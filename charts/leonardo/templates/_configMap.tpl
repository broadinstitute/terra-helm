{{- /* Generate the data component of a Cromwell config map */ -}}
{{- define "leonardo.configmap.data" -}}
data:
  resourceValidator.conf: |
{{ include "leonardo.config.resourceValidator" . | indent 4 }}  
  zombieMonitor.conf: |
{{ include "leonardo.config.zombieMonitor" . | indent 4 }}
{{- end -}}

{{- /* Generate a configmap for a Leonardo deployment */ -}}
{{- define "leonardo.configmap" -}}
{{- $settings := ._deploymentSettings -}}

{{- /*
  Render ConfigMap data, then checksum it, and store the checksum
  in the deploymentOutputs dictionary so that it be included as an annotation
  on the deployment's pod template. (see _deployment.tpl)

  This is used to automatically restart Leonardo pods when the ConfigMap
  changes.
*/ -}}
{{- $data := include "leonardo.configmap.data" . -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: leonardo-cm
  labels: {}
{{ $data }}
{{ end -}}
