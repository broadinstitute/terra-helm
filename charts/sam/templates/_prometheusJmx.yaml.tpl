{{- /* Configuration for Prometheus JMX exporter javaagent */ -}}
{{- define "sam.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}
