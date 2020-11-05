{{- /* Generate a rawls service */ -}}
{{- define "rawls.service" -}}
{{- $settings := ._deploymentSettings -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ $settings.serviceName | default $settings.name }}
  labels:
{{ include "rawls.labels" . | indent 4 }}
  annotations:
    cloud.google.com/app-protocols: '{"https":"HTTPS"}'
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
  {{- else -}}
  type: NodePort
  {{- end -}}
{{- end -}}