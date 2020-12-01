{{- /* Configuration for Prometheus JMX exporter javaagent */ -}}
{{- define "agora.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}
