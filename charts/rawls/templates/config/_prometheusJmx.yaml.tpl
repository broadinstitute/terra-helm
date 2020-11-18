{{- /* Configuration for Prometheus JMX exporter javaagent */ -}}
{{- define "rawls.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}