{{/*
Create labels to use for resources in this chart
*/}}
{{ include "crljanitor.labels" . | indent 4 }}
{{- define "crljanitor.labels" -}}
    helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/instance: {{ .Release.Name | quote }}
    app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
    app.kubernetes.io/component: crl-janitor
    app.kubernetes.io/part-of: terra
{{- end }}

{{/*
FQDN template
*/}}
{{- define "crljanitor.fqdn" -}}
    {{ .Values.domain.hostname -}}
    {{ if .Values.domain.namespaceEnv -}}
    	.{{.Values.global.terraEnv -}}
    {{ end -}}
    .{{ .Values.domain.suffix }}
{{- end }}

{{/*
Service firewall
*/}}
{{- define "crljanitor.servicefirewall" -}}
  {{- $addresses := merge .Values.serviceAllowedAddresses .Values.global.trustedAddresses -}}
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
