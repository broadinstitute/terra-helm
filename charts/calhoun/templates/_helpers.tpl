{{/*
Common labels
*/}}
{{- define "calhoun.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Values.name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: calhoun
app.kubernetes.io/part-of: terra
{{- end }}

{{/*
Selector labels
*/}}
{{- define "calhoun.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Values.name | quote }}
{{- end }}

{{/*
FQDN template
*/}}
{{- define "calhoun.fqdn" -}}
    {{ .Values.ingress.domain.hostname -}}
    {{ if .Values.ingress.domain.namespaceEnv -}}
    	.{{.Values.global.terraEnv -}}
    {{ end -}}
    .{{ .Values.ingress.domain.suffix }}
{{- end }}
