{{- /* Generate the data component of a Cromwell config map */ -}}
{{- define "leonardo.configmap.data" -}}
data:
  logback.xml: |
{{ include "leonardo.config.logback" . | indent 4 }}
{{- end -}}

{{- /* Generate a configmap for a Cromwell deployment */ -}}
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
  name: resource-validator-cm
  labels: {}
{{ $data }}
{{ end -}}
