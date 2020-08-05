{{- define "ontology.config.consent-ontology.yaml" -}}
server:
  type: simple
  applicationContextPath: /
  adminContextPath: /admin
  connector:
    type: http
    port: 8180
logging:
  level: INFO
  appenders:
    - type: console
      threshold: INFO
      target: stdout
    - type: sentry
      threshold: ERROR
      dsn: {{ .Values.sentry.dsn.key }}
      environment: {{ .Values.environment }}
  loggers:
    "org.semanticweb": ERROR
elasticSearch:
  servers:
    {{ .Values.elasticSearch.servers }}
  index: ontology
cors:
  allowedDomains: "*"
googleStore:
  password: /etc/consent-ontology-account.json
  endpoint: https://storage.googleapis.com/
  bucket: broad-dsde-dev-consent
storeOntology:
  bucketSubdirectory: ontology
  configurationFileName: /configuration
{{- end -}}
