{{- /* Configuration for Prometheus JMX exporter javaagent */ -}}
{{- define "externalcreds.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}
