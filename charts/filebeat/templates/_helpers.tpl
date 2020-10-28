{{/*
Create labels to use for resources in this chart
*/}}
{{- define "terra-filebeat.labels" }}
    helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/instance: {{ .Release.Name | quote }}
    app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
    app.kubernetes.io/component: filebeat
    app.kubernetes.io/part-of: dsp-tools
{{- end }}