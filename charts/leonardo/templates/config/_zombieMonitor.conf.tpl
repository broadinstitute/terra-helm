{{- define "cronjobs.config.zombieMonitor" -}}

# this is not really needed for zombie monitor. But currently all jobs share the same config object, we
# need this temporarily. We should remove this soon.
leonardo-pubsub.google-project = {{ .Values.cronjob.googleProject }}

report-destination-bucket = {{ .Values.commonCronjob.reportDestinationBucket }}

{{ end -}}
