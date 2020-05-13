{{/*
Create labels to use for resources in this chart
*/}}
{{- define "poc.labels" -}}
    {{- if eq .Values.devDeploy false -}}
    helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/instance: {{ .Release.Name | quote }}
    app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
    {{ end -}}
    app.kubernetes.io/component: poc
    app.kubernetes.io/part-of: terra
{{- end }}
