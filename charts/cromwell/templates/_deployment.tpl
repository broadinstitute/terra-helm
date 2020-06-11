{{- /* Generate a Cromwell deployment */ -}}
{{- define "cromwell.deployment" -}}
{{- $settings := .DeploymentSettings -}}
{{- $imageTag := $settings.imageTag | default .Values.appVersion -}}
{{- $legacyResourcePrefix := $settings.legacyResourcePrefix | default $settings.name -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ $settings.name }}
  labels:
{{ include "cromwell.labels" . | indent 4 }}
spec:
  revisionHistoryLimit: 0 # Cromwell is resource-intensive
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
  replicas: {{ $settings.replicas }}
  selector:
    matchLabels:
      deployment: {{ $settings.name }}
  template:
    metadata:
      labels:
        deployment: {{ $settings.name }}
    spec:
      serviceAccountName: cromwell-sa
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
      - name: cromwell-gc-logs
        emptyDir: {}
      containers:
      - name: app
        image: "broadinstitute/cromwell:{{ $imageTag }}"
        command: ["/bin/bash"]
        args: ["-c", "java ${JAVA_OPTS} -Dsystem.cromwell_id=gke-${K8S_POD_NAME} -jar /app/cromwell.jar ${CROMWELL_ARGS} ${*}", "--"]
        resources:
          requests:
            cpu: 7
            memory: 40Gi
          limits:
            memory: 50Gi
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
        - mountPath: /etc/cromwell.conf
          subPath: cromwell.conf
          name: app-ctmpls
          readOnly: true
        - mountPath: /etc/cromwell-account.json
          subPath: cromwell-account.json
          name: app-ctmpls
          readOnly: true
        - mountPath: /etc/cromwell-carbonite-account.json
          subPath: cromwell-carbonite-account.json
          name: app-ctmpls
          readOnly: true
        - mountPath: /var/log/gc
          name: cromwell-gc-logs
        readinessProbe:
          httpGet:
            path: /engine/latest/version
            port: 8000
          initialDelaySeconds: 0
          periodSeconds: 10
          timeoutSeconds: 1
          failureThreshold: 6
          successThreshold: 1
      - name: proxy
        image: broadinstitute/openidc-proxy:modsecurity_2_9_2
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
        - mountPath: /etc/apache2/sites-enabled/site.conf
          subPath: site.conf
          name: proxy-ctmpls
          readOnly: true
        - mountPath: /etc/apache2/conf-enabled/mpm_event.conf
          subPath: mpm_event.conf
          name: proxy-ctmpls
          readOnly: true
      - name: sqlproxy
        image: broadinstitute/cloudsqlproxy:1.11_2018117
        envFrom:
        - secretRef:
            name: {{ $legacyResourcePrefix }}-sqlproxy-env
        volumeMounts:
        - mountPath: /etc/sqlproxy-service-account.json
          subPath: sqlproxy-service-account.json
          name: sqlproxy-ctmpls
          readOnly: true
{{- end -}}
