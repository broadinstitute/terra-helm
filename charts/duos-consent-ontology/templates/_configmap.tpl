{{- /* Generate the data component of a Ontology config map */ -}}
{{- define "consent-ontology.configmap.data" -}}
data:
  consent-ontology.yaml: |
{{ include "consent-ontology.config.consent-ontology.yaml" . | indent 4 }}
  consent-service-account.json: | {}
{{- end -}}

{{- /* Generate a configmap for a Ontology deployment */ -}}
{{- define "consent-ontology.configmap" -}}
{{- $settings := ._deploymentSettings -}}

{{- /*
  Render ConfigMap data, then checksum it, and store the checksum
  in the deploymentOutputs dictionary so that it be included as an annotation
  on the deployment's pod template. (see _deployment.tpl)

  This is used to automatically restart Ontology pods when the ConfigMap
  changes.
*/ -}}
{{- $data := include "consent-ontology.configmap.data" . -}}
{{- $checksum := $data | sha256sum -}}
{{- $_ := set ._deploymentOutputs "configmapChecksum" $checksum -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $settings.name }}-cm
  labels:
{{ include "consent-ontology.labels" . | indent 4 }}
{{ $data }}
{{ end -}}
