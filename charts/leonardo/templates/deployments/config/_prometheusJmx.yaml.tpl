{{- /* TODO This overlaps with other charts, move into a library chart? */ -}}

{{- /* Configuration for Prometheus JMX exporter javaagent */ -}}
{{- define "leonardo.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}
