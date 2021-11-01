{{/*
Selector labels
*/}}
{{- define "postgres.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Values.name | quote }}
{{- end }}
