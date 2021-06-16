{{- /* Generate a Rawls deployment */ -}}
{{- define "rawls.deployment" -}}
{{- $settings := ._deploymentSettings -}}
{{- $outputs := ._deploymentOutputs -}}
{{- $imageTag := $settings.imageTag | default .Values.global.applicationVersion -}}
{{- $legacyResourcePrefix := $settings.legacyResourcePrefix | default $settings.name -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ $settings.name }}-deployment
  labels:
{{ include "rawls.labels" . | indent 4 }}
spec:
  replicas: {{ $settings.replicas }}
  revisionHistoryLimit: 0
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
  selector:
    matchLabels:
      deployment: {{ $settings.name}}
  template:
    metadata:
      labels:
        deployment: {{ $settings.name }}
{{ include "rawls.labels" . | indent 8 }}
      annotations:
        {{- /* Automatically restart deployments on config map change: */}}
        checksum/{{ $settings.name }}-cm: {{ $outputs.configmapChecksum }}
        {{- range $key, $value := $settings.annotations }}
        {{ $key }}: {{ $value }}
        {{- end }}
    spec:
      serviceAccountName: {{ $settings.name }}-sa
      hostAliases:
      - ip: 127.0.0.1
        hostnames:
        - app
        - sqlproxy
      volumes:
      - name: app-ctmpls
        secret:
          secretName: {{ $legacyResourcePrefix }}-app-ctmpls
      - name: proxy-ctmpls
        secret:
          secretName: {{ $legacyResourcePrefix }}-proxy-ctmpls
      - name: sqlproxy-ctmpls
        secret:
          secretName: {{ $legacyResourcePrefix }}-sqlproxy-ctmpls
      - name: {{ $settings.name }}-proxy-security-logs
        emptyDir: {}
      - name: {{ $settings.name }}-gc-logs
        emptyDir: {}
      - name: rawls-prometheusjmx-jar
        emptyDir: {}
      - name: {{ $settings.name }}-cm
        configMap:
          name: {{ $settings.name }}-cm
      containers:
      - name: {{ $settings.name }}-app
        image: "gcr.io/broad-dsp-gcr-public/rawls:{{ $imageTag }}"
        resources:
{{ toYaml .Values.resources | indent 10 }}
        ports:
          - containerPort: 8080
          - name: metrics
            containerPort: 9090
            protocol: TCP
        envFrom:
        - secretRef:
            name: {{ $legacyResourcePrefix }}-app-env
        env:
        - name: K8S_NODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
        - name: K8S_POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: PROMETHEUS_ARGS
          value: "-javaagent:/etc/prometheusjmx/prometheusjmx.jar=9090:/etc/rawls-cm/prometheusJmx.yaml"
        command: ["/bin/bash"]
        args:
        - '-c'
        - >- # Sleep 30 seconds to allow CloudSQL proxy time to start up. See DDO-1284 / BT-296
          sleep 30 &&
          java ${JAVA_OPTS}
          ${PROMETHEUS_ARGS}
          -jar $(find /rawls -name 'rawls*.jar')
        - '--'
        volumeMounts:
        - mountPath: /etc/rawls.conf
          subPath: rawls.conf
          name: app-ctmpls
          readOnly: true
        - mountPath: /etc/rawls-account.json
          subPath: rawls-account.json
          name: app-ctmpls
          readOnly: true
        - mountPath: /etc/rawls-account.pem
          subPath: rawls-account.pem
          name: app-ctmpls
          readOnly: true
        - mountPath: /etc/billing-account.pem
          subPath: billing-account.pem
          name: app-ctmpls
          readOnly: true
        - mountPath: /var/log/gc
          name: {{ $settings.name }}-gc-logs
        - mountPath: /etc/prometheusjmx/prometheusjmx.jar
          subPath: prometheusjmx.jar
          name: rawls-prometheusjmx-jar
          readOnly: true
        - mountPath: /etc/rawls-cm
          name: {{ $settings.name }}-cm
          readOnly: true
        {{- if $settings.probes.readiness.enabled }}
        readinessProbe:
          {{- toYaml $settings.probes.readiness.spec | nindent 10 }}
        {{- end }}
        {{- if $settings.probes.liveness.enabled }}
        livenessProbe:
          {{- toYaml $settings.probes.liveness.spec | nindent 10 }}
        {{- end }}
        {{- if $settings.probes.startup.enabled }}
        startupProbe:
          {{- toYaml $settings.probes.startup.spec | nindent 10 }}
        {{- end }}
      - name: {{ $settings.name }}-sqlproxy
        image: broadinstitute/cloudsqlproxy:1.11_20180808
        envFrom:
        - secretRef:
            name: {{ $legacyResourcePrefix }}-sqlproxy-env
        volumeMounts:
        - mountPath: /etc/sqlproxy-service-account.json
          subPath: sqlproxy-service-account.json
          name: sqlproxy-ctmpls
          readOnly: true
      - name: {{ $settings.name }}-proxy
        image: broadinstitute/openidc-proxy:tcell-mpm-big
        ports:
          - containerPort: 443
          - containerPort: 80
          - containerPort: 8888
        envFrom:
        - secretRef:
            name: {{ $legacyResourcePrefix }}-proxy-env
        volumeMounts:
        - mountPath: /etc/ssl/certs/server.crt
          subPath: server.crt
          name: proxy-ctmpls
          readOnly: true
        - mountPath: /etc/ssl/private/server.key
          subPath: server.key
          name: proxy-ctmpls
          readOnly: true
        - mountPath: /etc/ssl/certs/ca-bundle.crt
          subPath: ca-bundle.crt
          name: proxy-ctmpls
          readOnly: true
        - mountPath: /etc/apache2/sites-available/site.conf
          subPath: site.conf
          name: proxy-ctmpls
          readOnly: true
        - mountPath: /etc/apache2/sites-enabled/mod_security_logging.conf
          subPath: mod_security_logging.conf
          name: proxy-ctmpls
          readOnly: true
        - mountPath: /etc/modsecurity/mod_security_ignore.conf
          subPath: mod_security_ignore.conf
          name: proxy-ctmpls
          readOnly: true
        - mountPath: /etc/apache2/tcell_agent.config
          subPath: tcell_agent.config
          name: proxy-ctmpls
          readOnly: true
        - mountPath: /var/log/modsecurity
          name: {{ $settings.name }}-proxy-security-logs
      initContainers:
      - name: download-prometheusjmx-jar
        image: alpine:3.12.0
        command: ["wget", "-O", "/rawls-prometheusjmx-jar/prometheusjmx.jar", "https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.13.0/jmx_prometheus_javaagent-0.13.0.jar"]
        volumeMounts:
        - mountPath: /rawls-prometheusjmx-jar
          name: rawls-prometheusjmx-jar
{{- end -}}
