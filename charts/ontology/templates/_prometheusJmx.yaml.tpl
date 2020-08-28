{{- /* Configuration for Prometheus JMX exporter javaagent */ -}}
{{- define "ontology.config.prometheusJmx" -}}
rules:
- pattern: ".*"
{{ end -}}