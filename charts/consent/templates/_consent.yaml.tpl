{{- define "consent.config.yaml" -}}
server:
  type: simple
  applicationContextPath: /
  adminContextPath: /admin
  connector:
    type: http
    port: 8080
logging:
  level: INFO
  appenders:
    - type: console
      threshold: INFO
      target: stdout
    - type: sentry
      dsn: https://foo:bar@sentry.io/baz {{/* Override on the command line */}}
      threshold: ERROR
      environment: {{ .Values.environment }}
  loggers:
    "org.semanticweb": ERROR
elasticSearch:
  servers:
    - {{ .Values.elasticSearchServer1 }}
    - {{ .Values.elasticSearchServer2 }}
    - {{ .Values.elasticSearchServer3 }}
  index: ontology
googleStore:
  password: /etc/service-account.json
  endpoint: https://storage.googleapis.com/
  bucket: {{ .Values.googleBucket }}
storeOntology:
  bucketSubdirectory: {{ .Values.googleBucketSubdirectory }}
  configurationFileName: /configuration
{{- end -}}
