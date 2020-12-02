{{- /* Generate a rawls service */ -}}
{{- define "rawls.service" -}}
{{- $settings := ._deploymentSettings -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ $settings.serviceName | default $settings.name }}
  annotations:
    cloud.google.com/app-protocols: '{"https":"HTTPS"}'
    cloud.google.com/neg: '{"ingress": true}'
    cloud.google.com/backend-config: '{"default": "{{ .Chart.Name }}-ingress-backendconfig"}'
  labels:
{{ include "rawls.labels" . | indent 4 }}
spec:
  selector:
    deployment: {{ $settings.name }}
  ports:
  - name: https
    protocol: TCP
    port: 443
    targetPort: 443
  {{- if $settings.serviceIP }}
  type: LoadBalancer
  loadBalancerIP: {{ $settings.serviceIP }}
  {{- else }}
  type: ClusterIP
  {{- end -}}
{{- end -}}