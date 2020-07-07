{{- /* Generate a Cromwell service */ -}}
{{- define "cromwell.service" -}}
{{- $settings := ._deploymentSettings -}}
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
  {{- $globalAllowed := $.Values.global.trustedAddresses | deepCopy -}}
  {{- $serviceAllowed := $settings.serviceAllowedAddresses | deepCopy -}}
  {{- $allAllowed := mergeOverwrite $globalAllowed $serviceAllowed -}}
  {{- if not (empty $allAllowed) }}
  loadBalancerSourceRanges:
  {{- range $nick, $cidrs := $allAllowed }}
  # {{ $nick }}
  {{- range $cidr := $cidrs }}
  - {{ $cidr }}
  {{- end -}}
  {{- end -}}
  {{- end }}
{{- end -}}
