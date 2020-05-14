{{/*
Create labels to use for resources in this chart
*/}}
{{- define "opendj.labels" -}}
    helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/instance: {{ .Release.Name | quote }}
    app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
    app.kubernetes.io/component: opendj
    app.kubernetes.io/part-of: terra
{{- end }}

{{/*
Define base domain
*/}}
{{ define "opendj.baseDn" -}}
  {{- if .Values.baseDn -}}
    dc=dsde-{{ .Values.global.terraEnv }},dc=broadinstitute,dc=org
  {{- else -}}
    {{ .Values.baseDn }}
  {{- end -}}
{{- end }}
