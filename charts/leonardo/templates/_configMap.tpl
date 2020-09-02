{{- /* Generate the data component of a Cromwell config map */ -}}
{{- define "leonardo.configmap.data" -}}
data:
  logback.xml: |
{{ include "resourceValidator.config.logback" . | indent 4 }}
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
{{- $checksum := $data | sha256sum -}}
{{- $_ := set ._deploymentOutputs "configmapChecksum" $checksum -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $settings.name }}-cm
  labels: {}
{{ $data }}
{{ end -}}
