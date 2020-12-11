{{- /* Configuration for Prometheus JMX exporter javaagent */ -}}
{{- define "firecloudorch.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}