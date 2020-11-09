{{- /* Generate a Leonardo service */ -}}
{{- define "leonardo.service" -}}
{{- $settings := ._deploymentSettings -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ $settings.name }}-service
  labels:
{{ include "leonardo.labels" . | indent 4 }}
spec:
  selector:
    deployment: {{ $settings.name }}-deployment
  ports:
  - name: https
    protocol: TCP
    port: 443
    targetPort: 443
{{ end -}}
