{{- /* Configuration for Prometheus JMX exporter javaagent */ -}}
{{- define "thurloe.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}