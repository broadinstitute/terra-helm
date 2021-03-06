{{/*
Create labels to use for resources in this chart
*/}}
{{- define "identityconcentrator.labels" -}}
    helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/instance: {{ .Release.Name | quote }}
    app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
    app.kubernetes.io/component: identityconcentrator
    app.kubernetes.io/part-of: terra
{{- end }}
