{{- /* Configuration for Prometheus JMX exporter javaagent */-}}
{{- define "cromwell.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}