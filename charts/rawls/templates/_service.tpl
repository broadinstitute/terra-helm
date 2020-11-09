{{- /* Generate a rawls service */ -}}
{{- define "rawls.service" -}}
{{- $settings := ._deploymentSettings -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ $settings.serviceName | default $settings.name }}
  annotations:
    cloud.google.com/app-protocols: '{"https":"HTTPS"}'
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
  {{- else -}}
  type: NodePort
  {{- end -}}
{{- end -}}