{{/*
Create labels to use for resources in this chart
*/}}
{{- define "rbs.labels" -}}
    helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/instance: {{ .Release.Name | quote }}
    app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
    app.kubernetes.io/component: rbs
    app.kubernetes.io/part-of: terra
{{- end }}

{{/*
FQDN template
*/}}
{{- define "rbs.fqdn" -}}
    {{ .Values.domain.hostname -}}
    {{ if .Values.domain.namespaceEnv -}}
    	.{{.Values.global.terraEnv -}}
    {{ end -}}
    .{{ .Values.domain.suffix }}
{{- end }}

{{/*
Service firewall
*/}}
{{- define "rbs.servicefirewall" -}}
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
