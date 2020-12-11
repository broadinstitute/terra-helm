{{- /* Configuration for Prometheus JMX exporter javaagent */ -}}
{{- define "workspacemanager.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}
