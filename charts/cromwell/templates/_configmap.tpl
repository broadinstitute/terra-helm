{{- /* Generate the data component of a Cromwell config map */ -}}
{{- define "cromwell.configmap.data" -}}
data:
  logback.xml: |
{{ include "cromwell.config.logback" . | indent 4 }}
  prometheusJmx.yaml: |
{{ include "cromwell.config.prometheusJmx" . | indent 4 }}
{{- end -}}

{{- /* Generate a configmap for a Cromwell deployment */ -}}
{{- define "cromwell.configmap" -}}
{{- $settings := ._deploymentSettings -}}

{{- /*
  Render ConfigMap data, then checksum it, and store the checksum
  in the deploymentOutputs dictionary so that it be included as an annotation
  on the deployment's pod template. (see _deployment.tpl)

  This is used to automatically restart Cromwell pods when the ConfigMap
  changes.
*/ -}}
{{- $data := include "cromwell.configmap.data" . -}}
{{- $checksum := $data | sha256sum -}}
{{- $_ := set ._deploymentOutputs "configmapChecksum" $checksum -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $settings.name }}-cm
  labels:
{{ include "cromwell.labels" . | indent 4 }}
{{ $data }}
{{ end -}}
