{{/*
Create labels to use for resources in this chart
*/}}
{{- define "consent-ontology.labels" -}}
    helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
    app.kubernetes.io/name: {{ .Release.Name }}
    app.kubernetes.io/instance: {{ .Release.Name | quote }}
    app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
    app.kubernetes.io/component: consent-ontology
    app.kubernetes.io/part-of: terra
{{- end -}}
