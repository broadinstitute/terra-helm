{{- /* Generate a Cromwell service */ -}}
{{- define "cromwell.service" -}}
{{- $settings := .DeploymentSettings -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ $settings.serviceName | default $settings.name }}
  labels:
{{ include "cromwell.labels" . | indent 4 }}
spec:
  selector:
    deployment: {{ $settings.name }}
  ports:
  - protocol: TCP
    port: 443
    targetPort: 443
  type: LoadBalancer
  loadBalancerIP: {{ $settings.serviceIP }}
  {{- if not (empty $settings.serviceWhitelist) }}
  loadBalancerSourceRanges:
  {{- range $nick, $cidrs := $settings.serviceWhitelist }}
  # {{ $nick }}
  {{- range $cidr := $cidrs }}
  - {{ $cidr }}
  {{- end -}}
  {{- end -}}
  {{- end }}
{{- end -}}
