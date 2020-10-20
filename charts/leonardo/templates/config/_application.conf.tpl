{{- define "leonardo.config.resourceValidator" -}}

googleProject = {{ .Values.cronjob.googleProject }}

report-destination-bucket = {{ .Values.commonCronjob.reportDestinationBucket }}

{{ end -}}
