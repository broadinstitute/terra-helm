{{/*
Create labels to use for resources in this chart
*/}}
{{- define "duos.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ .Release.Name }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: {{ .Chart.Name }}
app.kubernetes.io/part-of: terra
app: {{ .Chart.Name }}
{{- end -}}
