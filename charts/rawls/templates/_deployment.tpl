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
{{- end -}}
