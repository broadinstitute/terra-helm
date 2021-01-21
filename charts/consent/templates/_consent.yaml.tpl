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
    "org.reflections.Reflections": ERROR
    "org.apache.pdfbox": ERROR
database:
  driverClass: org.postgresql.Driver
  user: foo {{/* Override on the command line */}}
  password: foo {{/* Override on the command line */}}
  url: {{ .Values.databaseUrl }}
  initialSize: 20
  minSize: 20
  maxSize: 128
  validationQuery: SELECT 1
elasticSearch:
  servers:
    - {{ .Values.elasticSearchServer1 }}
    - {{ .Values.elasticSearchServer2 }}
    - {{ .Values.elasticSearchServer3 }}
  indexName: ontology
googleStore:
  password: /etc/service-account.json
  endpoint: https://storage.googleapis.com/
  bucket: {{ .Values.googleBucket }}
datasets:
  - Melanoma-Regev-Izar-Garraway-DFCI-ICR
  - Melanoma_Regev
services:
  localURL: {{ .Values.servicesLocalUrl }}
  ontologyURL: {{ .Values.servicesOntologyUrl }}
mailConfiguration:
  activateEmailNotifications: {{ .Values.emailNotificationsEnabled }}
  googleAccount: duos@broadinstitute.org
  sendGridApiKey: foo {{/* Override on the command line */}}
freeMarkerConfiguration:
  templateDirectory: /freemarker
  defaultEncoding: UTF-8
googleAuthentication:
  clientId: {{ .Values.googleClientId }}
basicAuthentication:
  users:
    - user: foo {{/* Override on the command line */}}
      password: foo {{/* Override on the command line */}}
storeOntology:
  bucketSubdirectory: {{ .Values.googleBucketSubdirectory }}
  configurationFileName: /configuration
{{- end -}}
