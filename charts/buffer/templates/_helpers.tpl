{{/*
Common labels
*/}}
{{- define "buffer.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Values.name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: buffer
app.kubernetes.io/part-of: terra
{{- end }}

{{/*
Selector labels
*/}}
{{- define "buffer.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Values.name | quote }}
{{- end }}

{{/*
FQDN template
*/}}
{{- define "buffer.fqdn" -}}
    {{ .Values.ingress.domain.hostname -}}
    {{ if .Values.ingress.domain.namespaceEnv -}}
    	.{{.Values.global.terraEnv -}}
    {{ end -}}
    .{{ .Values.ingress.domain.suffix }}
{{- end }}
