{{/*
Create labels to use for resources in this chart
*/}}
{{- define "filebeat.labels" }}
    helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/instance: {{ .Release.Name | quote }}
    app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
    app.kubernetes.io/component: filebeat
    app.kubernetes.io/part-of: dsp-tools
{{- end }}

{{/*
Templates a list of regex's used to ignore logs from list of application names
*/}}
{{- define "filebeat.ignoreServices" }}
{{- range .Values.ignore }}
- regexp:
    kubernetes.pod.name: "^{{ . }}.*"
{{- end }}{{- end }}
