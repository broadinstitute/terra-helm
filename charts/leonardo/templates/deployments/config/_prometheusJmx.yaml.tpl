{{- /* Configuration for Prometheus JMX exporter javaagent */ -}}
{{- define "leonardo.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}
