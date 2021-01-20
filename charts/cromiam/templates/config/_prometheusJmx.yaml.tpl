{{- /* Configuration for Prometheus JMX exporter javaagent */ -}}
{{- define "cromiam.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}
