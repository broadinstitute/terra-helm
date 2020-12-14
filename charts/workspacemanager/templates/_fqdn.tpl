{{/*
FQDN template
*/}}
{{- define "workspacemanager.fqdn" -}}
    {{ .Values.ingress.domain.hostname -}}
    {{ if .Values.ingress.domain.namespaceEnv -}}
    	.{{.Values.global.terraEnv -}}
    {{ end -}}
    .{{ .Values.ingress.domain.suffix }}
{{- end }}
