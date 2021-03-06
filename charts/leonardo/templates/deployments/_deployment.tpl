{{- /* Generate a Leonardo deployment */ -}}
{{- define "leonardo.deployment" -}}
{{- $settings := ._deploymentSettings -}}
{{- $outputs := ._deploymentOutputs -}}
{{- $imageTag := $settings.imageTag | default .Values.global.applicationVersion -}}
{{- $legacyResourcePrefix := $settings.name -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ $settings.name }}-deployment
  labels:
{{ include "leonardo.labels" . | indent 4 }}
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
  revisionHistoryLimit: 0
  replicas: {{ $settings.replicas }}
  selector:
    matchLabels:
      deployment: {{ $settings.name }}-deployment
  template:
    metadata:
      labels:
        deployment: {{ $settings.name }}-deployment
{{ include "leonardo.labels" . | indent 8 }}
      annotations:
        {{- /* Automatically restart deployments on config map change: */}}
        checksum/{{ $settings.name }}-cm: {{ $outputs.configmapChecksum }}
    spec:
      serviceAccountName: leonardo-sa
      # Containers are configured to talk to each other by name
      # via docker-compose links; make corresponding aliases
      # to loopback in /etc/hosts
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
      - name: {{ $settings.name }}-cm
        configMap:
          name: {{ $settings.name }}-cm
      - name: {{ $settings.name }}-gc-logs
        emptyDir: {}
      - name: {{ $settings.name }}-modsecurity-logs
        emptyDir: {}
      - name: prometheusjmx-jar
        emptyDir: {}
      containers:
      - name: {{ $settings.name }}-app
        image: "{{ $settings.imageRepository }}:{{ $imageTag }}"
        ports:
        - name: app
          containerPort: 8080
          protocol: TCP
        - name: metrics
          containerPort: 9090
          protocol: TCP
        resources: # Mimic existing GCE vm requirements
          requests:
            cpu: 4
            memory: 9Gi
          limits:
            cpu: 4
            memory: 9Gi
        envFrom:
        - secretRef:
            name: {{ $legacyResourcePrefix }}-app-env
        env:
        # Make node, pod name accessible to app as env vars
        - name: K8S_NODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
        - name: K8S_POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        volumeMounts:
        - mountPath: /etc/leonardo.conf
          subPath: leonardo.conf
          name: app-ctmpls
        - mountPath: /etc/leonardo-account.pem
          subPath: leonardo-account.pem
          readOnly: true
          name: app-ctmpls
        - mountPath: /etc/leonardo-account.json
          subPath: leonardo-account.json
          readOnly: true
          name: app-ctmpls
        - mountPath: /etc/jupyter-server.crt
          subPath: jupyter-server.crt
          readOnly: true
          name: app-ctmpls        
        - mountPath: /leonardo/terra-app-setup/tls.crt
          subPath: jupyter-server.crt
          readOnly: true
          name: app-ctmpls
        - mountPath: /etc/jupyter-server.key
          subPath: jupyter-server.key
          readOnly: true
          name: app-ctmpls        
        - mountPath: /leonardo/terra-app-setup/tls.key
          subPath: jupyter-server.key
          readOnly: true
          name: app-ctmpls
        - mountPath: /etc/leo-client.p12
          subPath: leo-client.p12
          readOnly: true
          name: app-ctmpls
        - mountPath: /etc/rootCA.key
          subPath: rootCA.key
          readOnly: true
          name: app-ctmpls
        - mountPath: /etc/rootCA.pem
          subPath: rootCA.pem
          readOnly: true
          name: app-ctmpls       
        - mountPath: /leonardo/terra-app-setup/ca.crt
          subPath: rootCA.pem
          readOnly: true
          name: app-ctmpls
        - mountPath: /etc/rstudio-license-file.lic
          subPath: rstudio-license-file.lic
          readOnly: true
          name: app-ctmpls
        - mountPath: /var/log/gc
          name: {{ $settings.name }}-gc-logs
        - mountPath: /etc/prometheusjmx/prometheusjmx.jar
          subPath: prometheusjmx.jar
          name: prometheusjmx-jar
          readOnly: true
        - mountPath: /etc/leonardo-cm
          name: {{ $settings.name }}-cm
          readOnly: true
        # Note: These readiness settings only apply to Kubernetes' internal load
        # balancing mechanism -- there's a separate health check setting for
        # Leo's Ingress / GCP load balancer in the Ingress's backendConfig
        {{- if $settings.probes.readiness.enabled }}
        readinessProbe:
          {{- toYaml $settings.probes.readiness.spec | nindent 10 }}
        {{- end }}
        {{- if $settings.probes.liveness.enabled }}
        livenessProbe:
          {{- toYaml $settings.probes.liveness.spec | nindent 10 }}
        {{- end }}
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
        - mountPath: /etc/apache2/tcell_agent.config
          subPath: tcell_agent.config
          name: proxy-ctmpls
          readOnly: true
        - mountPath: /var/log/modsecurity
          name: {{ $settings.name }}-modsecurity-logs
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
      initContainers:
      - name: download-prometheusjmx-jar
        image: alpine:3.12.0
        command: ["wget", "-O", "/prometheusjmx-jar/prometheusjmx.jar", "https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.13.0/jmx_prometheus_javaagent-0.13.0.jar"]
        volumeMounts:
        - mountPath: /prometheusjmx-jar
          name: prometheusjmx-jar
{{ end -}}
