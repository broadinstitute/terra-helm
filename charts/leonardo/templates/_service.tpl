{{- /* Generate a Leonardo service */ -}}
{{- define "leonardo.service" -}}
{{- $settings := ._deploymentSettings -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ $settings.name }}-service
  labels:
{{ include "leonardo.labels" . | indent 4 }}
  annotations:
    # Enable container-native load balancing https://cloud.google.com/kubernetes-engine/docs/how-to/container-native-load-balancing
    cloud.google.com/neg: '{"ingress": true}'
spec:
  type: ClusterIP
  selector:
    deployment: {{ $settings.name }}-deployment
  ports:
  - name: https
    protocol: TCP
    port: 443
    targetPort: 443
{{ end -}}
