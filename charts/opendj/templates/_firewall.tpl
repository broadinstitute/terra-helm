{{/*
Service firewall
*/}}
{{- define "opendj.firewall" -}}
  {{- $addresses := merge .Values.service.allowedAddresses .Values.global.trustedAddresses -}}
  {{- if $addresses | empty -}}
    {{- fail "Please specify at least one allowed address" -}}
  {{- end -}}

  {{- range $nickname, $cidrs := $addresses }}
  # {{ $nickname }}
  {{- range $cidr := $cidrs }}
  - {{ $cidr }}
  {{- end -}}
  {{- end -}}
{{- end }}
