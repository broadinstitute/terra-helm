{{- /* Configuration for Cloud SQL client */ -}}
{{- define "consent.config.sqlproxy.env" -}}
GOOGLE_PROJECT={{ .Values.googleProject }}
CLOUDSQL_ZONE={{ .Values.googleProjectZone  }}
CLOUDSQL_INSTANCE={{ .Values.cloudSqlInstance  }}
CLOUDSQL_MAXCONNS=300
PORT=5432
{{ end -}}