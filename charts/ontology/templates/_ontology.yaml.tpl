{{- define "ontology.config.yaml" -}}
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
    - {{ .Values.elasticSearch.server1 }}
    - {{ .Values.elasticSearch.server2 }}
    - {{ .Values.elasticSearch.server3 }}
  index: ontology
cors:
  allowedDomains: "*"
googleStore:
  password: /etc/service-account.json
  endpoint: https://storage.googleapis.com/
  bucket: {{ .Values.google.project }}
storeOntology:
  bucketSubdirectory: {{ .Values.google.subdirectory }}
  configurationFileName: /configuration
{{- end -}}
