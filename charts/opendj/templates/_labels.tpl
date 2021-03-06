{{- /*
Create labels to use for resources in this chart

See
https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/
*/ -}}
{{- define "opendj.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Values.name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: opendj
app.kubernetes.io/part-of: terra
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "opendj.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Values.name | quote }}
{{- end }}
