{{- /* Generate a Leonardo ingress */ -}}
{{- define "leonardo.ingress" -}}
{{- $settings := ._deploymentSettings -}}
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: {{ $settings.name }}-ingress
  labels:
{{ include "leonardo.labels" . | indent 4 }}
{{- if $settings.ingress.annotations }}
  annotations:
    {{ $settings.ingress.annotations | toYaml | indent 4 | trim }}
{{- end }}
spec:
  rules:
  - http:
      paths:
      - path: /*
        backend:
          serviceName: {{ $settings.name }}-service
          servicePort: 443
{{ end -}}
