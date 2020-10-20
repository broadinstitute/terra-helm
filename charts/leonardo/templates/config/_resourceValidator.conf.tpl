{{- define "leonardo.config.resourceValidator" -}}

leonardo-pubsub.google-project = {{ .Values.cronjob.googleProject }}

report-destination-bucket = {{ .Values.commonCronjob.reportDestinationBucket }}

{{ end -}}
