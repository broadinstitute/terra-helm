{{/*
Create labels to use for resources in this chart
*/}}
{{- define "dsp-argocd.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: argocd
app.kubernetes.io/part-of: {{ .Chart.Name | quote }}
{{- end -}}
