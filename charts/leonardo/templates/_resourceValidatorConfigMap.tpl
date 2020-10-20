{{- /* Generate the data component of a Cromwell config map */ -}}
{{- define "resource-validator.configmap.data" -}}
data:
  resourceValidator.conf: |
{{ include "resource-validator.config.resourceValidator" . | indent 4 }}  
{{- end -}}

{{- /* Generate a configmap for a resource-validator deployment */ -}}
{{- define "resource-validator.configmap" -}}
{{- $settings := ._deploymentSettings -}}

{{- /*
  Render ConfigMap data, then checksum it, and store the checksum
  in the deploymentOutputs dictionary so that it be included as an annotation
  on the deployment's pod template. (see _deployment.tpl)

  This is used to automatically restart resource-validator pods when the ConfigMap
  changes.
*/ -}}
{{- $data := include "resource-validator.configmap.data" . -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: resource-validator-cm
  labels: {}
{{ $data }}
{{ end -}}
