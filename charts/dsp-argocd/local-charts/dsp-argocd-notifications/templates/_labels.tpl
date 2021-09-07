{{/*
Create labels to use for resources in this chart
*/}}
{{- define "dsp-argocd-notifications.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ .Chart.Name | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: "argocd-notifications"
app.kubernetes.io/part-of: {{ .Chart.Name | quote }}
{{- end -}}
