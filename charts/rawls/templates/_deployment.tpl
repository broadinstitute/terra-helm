{{- /* Generate a Rawls deployment */ -}}
{{- define "rawls.deployment" -}}
{{- $settings := ._deploymentSettings -}}
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
    spec: 
      serviceAccountName: rawls-sa
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
<<<<<<< HEAD
      - name: rawls-prometheusjmx-jar
        emptyDir: {}
=======
>>>>>>> f7f8e005f2b0110a00f707f1228bea083fa0bee2
      containers:
      - name: {{ $settings.name }}-app
        image: "gcr.io/broad-dsp-gcr-public/rawls:{{ $imageTag }}"
        ports: 
          - name: metrics
            containerPort: 9090
            protocol: TCP
        envFrom:
        - secretRef:
            name: {{ $legacyResourcePrefix }}-app-env
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
<<<<<<< HEAD
        - mountPath: /etc/prometheusjmx/prometheusjmx.jar
          subPath: prometheusjmx.jar
          name: rawls-prometheusjmx-jar
          readOnly: true
=======
>>>>>>> f7f8e005f2b0110a00f707f1228bea083fa0bee2
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
<<<<<<< HEAD
      initContainers:
      - name: download-prometheusjmx-jar
        image: alpine:3.12.0
        command: ["wget", "-O", "/rawls-prometheusjmx-jar/prometheusjmx.jar", "https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.13.0/jmx_prometheus_javaagent-0.13.0.jar"]
        volumeMounts:
        - mountPath: /rawls-prometheusjmx-jar
          name: rawls-prometheusjmx-jar
=======
>>>>>>> f7f8e005f2b0110a00f707f1228bea083fa0bee2
{{- end -}}

