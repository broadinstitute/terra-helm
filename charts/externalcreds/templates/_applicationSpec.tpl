{{- $imageTag := .Values.imageConfig.tag | default .Values.global.applicationVersion -}}
{{- define "externalcreds.app.volumes" -}}
- name: app-sa-creds
  secret:
    secretName: {{ .Values.name }}-app-sa
- name: app-providers
  secret:
    secretName: {{ .Values.name }}-providers
- name: app-swagger-client-id
  secret:
    secretName: {{ .Values.name }}-swagger-client-id
- name: app-allowed-jwks
  configMap:
    name: {{ .Values.name }}-allowed-jwks
    items:
      - key: allowed-jwks.yaml
        path: allowed-jwks.yaml
{{- if .Values.prometheus.enabled }}
- name: {{ .Values.name }}-prometheusjmx-config
  configMap:
    name: {{ .Values.name }}-prometheus-configmap
- name: {{ .Values.name }}-prometheusjmx-jar
  emptyDir: {}
{{- end }}
{{- end -}}

{{- define "externalcreds.sqlproxy.volumes" -}}
{{- if not .Values.postgres.enabled }}
- name: cloudsql-sa-creds
  secret:
    secretName: {{ .Values.name }}-sqlproxy-sa
{{- end }}
{{- end -}}

{{- define "externalcreds.app.container" -}}
- name: {{ .Values.name }}
  image: "{{- if .Values.image -}}
      {{ .Values.image }}
    {{- else -}}
      {{ .Values.imageConfig.repository }}:{{ $imageTag }}
    {{- end }}"
  imagePullPolicy: {{ .Values.imageConfig.imagePullPolicy }}
  ports:
  - name: status
    containerPort: 8080
    protocol: TCP
  {{- if .Values.prometheus.enabled }}
  - name: metrics
    containerPort: 9090
    protocol: TCP
  {{- end }}
  resources:
{{ toYaml .Values.resources | indent 4 }}
  env:
  {{- if .Values.prometheus.enabled }}
  - name: JAVA_TOOL_OPTIONS
    value: "-javaagent:/etc/prometheusjmx/prometheusjmx.jar=9090:/etc/{{ .Values.name }}-prometheusjmx-config/prometheusJmx.yaml"
  {{- end }}
  {{- if not .Values.postgres.enabled }}
  - name: DATABASE_USER
    valueFrom:
      secretKeyRef:
        name: {{ .Values.name }}-postgres-db-creds
        key: username
  - name: DATABASE_USER_PASSWORD
    valueFrom:
      secretKeyRef:
        name: {{ .Values.name }}-postgres-db-creds
        key: password
  - name: DATABASE_NAME
    valueFrom:
      secretKeyRef:
        name: {{ .Values.name }}-postgres-db-creds
        key: db
  {{- else }}
  - name: DATABASE_HOSTNAME
    value: {{ .Values.name }}-postgres-service.{{ .Release.Namespace }}.svc.cluster.local
  - name: DATABASE_USER
    value: postgres
  - name: DATABASE_USER_PASSWORD
    value: {{ .Values.postgres.password }}
  - name: DATABASE_NAME
    value: {{ index .Values.postgres.dbs 0 }}
  {{- end }}
  {{- if .Values.initDB }}
  - name: INIT_DB
    value: 'true'
  {{- end }}
  - name: SAM_ADDRESS
    value: {{ .Values.samAddress }}
  - name: SAMPLING_PROBABILITY
    value: "{{ .Values.samplingProbability }}"
  - name: GOOGLE_APPLICATION_CREDENTIALS
    value: /secrets/app/service-account.json
  - name: CLOUD_TRACE_ENABLED
    value: "{{ .Values.cloudTraceEnabled }}"
  - name: EXTERNALCREDS_INGRESS_DOMAIN_NAME
    value: "{{ template "externalcreds.fqdn" . }}"
  volumeMounts:
  - name: app-sa-creds
    mountPath: /secrets/app
    readOnly: true
  - name: app-providers
    mountPath: /app/resources/rendered/providers.yaml
    subPath: providers.yaml
  - name: app-swagger-client-id
    mountPath: /app/resources/rendered/swagger-client-id
    subPath: swagger-client-id
  - name: app-allowed-jwks
    mountPath: /app/resources/rendered/allowed_jwks.yaml
    subPath: allowed-jwks.yaml
  {{- if .Values.prometheus.enabled }}
  - name: {{ .Values.name }}-prometheusjmx-config
    mountPath: /etc/{{ .Values.name }}-prometheusjmx-config
  - name: {{ .Values.name }}-prometheusjmx-jar
    mountPath: /etc/prometheusjmx/prometheusjmx.jar
    subPath: prometheusjmx.jar
  {{- end }}
  {{- if .Values.probes.readiness.enabled }}
  readinessProbe:
    {{- toYaml .Values.probes.readiness.spec | nindent 10 }}
  {{- end }}
  {{- if .Values.probes.liveness.enabled }}
  livenessProbe:
    {{- toYaml .Values.probes.liveness.spec | nindent 10 }}
  {{- end }}
  {{- if .Values.probes.startup.enabled }}
  startupProbe:
    {{- toYaml .Values.probes.startup.spec | nindent 10 }}
  {{- end }}
{{- end -}}

{{- define "externalcreds.sqlproxy.container" -}}
{{- if not .Values.postgres.enabled }}
- name: cloudsql-proxy
  image: gcr.io/cloudsql-docker/gce-proxy:1.16
  env:
  - name: SQL_INSTANCE_PROJECT
    valueFrom:
      secretKeyRef:
        name: {{ .Values.name }}-cloudsql-postgres-instance
        key: project
  - name: SQL_INSTANCE_REGION
    valueFrom:
      secretKeyRef:
        name: {{ .Values.name }}-cloudsql-postgres-instance
        key: region
  - name: SQL_INSTANCE_NAME
    valueFrom:
      secretKeyRef:
        name: {{ .Values.name }}-cloudsql-postgres-instance
        key: name
  command: ["/cloud_sql_proxy",
            "-instances=$(SQL_INSTANCE_PROJECT):$(SQL_INSTANCE_REGION):$(SQL_INSTANCE_NAME)=tcp:5432",
            "-credential_file=/secrets/cloudsql/service-account.json"]
  securityContext:
    runAsUser: 2  # non-root user
    allowPrivilegeEscalation: false
  volumeMounts:
  - name: cloudsql-sa-creds
    mountPath: /secrets/cloudsql
    readOnly: true
{{- end }}
{{- end -}}
