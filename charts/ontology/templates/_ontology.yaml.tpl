{{- define "ontology.config.yaml" -}}
server:
  applicationContextPath: /
  adminContextPath: /admin
  applicationConnectors:
    - type: http
      port: 8080
  adminConnectors:
    - type: http
      port: 8081
  requestLog:
    appenders:
      - type: console
        layout:
          type: access-json
logging:
  level: INFO
  appenders:
    - type: console
      threshold: INFO
      target: stdout
      layout:
        type: json
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
