{{/*
Create labels to use for resources in this chart
*/}}
{{- define "workspacemanager.labels" -}}
    helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/instance: {{ .Release.Name | quote }}
    app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
    app.kubernetes.io/component: workspacemanager
    app.kubernetes.io/part-of: terra
{{- end }}

{{/*
FQDN template
*/}}
{{- define "workspacemanager.fqdn" -}}
    {{ .Values.domain.hostname -}}
    {{ if .Values.domain.namespaceEnv -}}
    	.{{.Values.global.terraEnv -}}
    {{ end -}}
    .{{ .Values.domain.suffix }}
{{- end }}

{{/*
Service firewall
*/}}
{{- define "workspacemanager.servicefirewall" -}}
  {{- $trustedAddresses := .Values.global.trustedAddresses | default dict -}}
  {{- $allowedAddresses := merge .Values.serviceAllowedAddresses $trustedAddresses -}}
  {{- if $allowedAddresses | empty -}}
    {{- fail "Please specify at least one allowed address" -}}
  {{- end -}}

  {{- range $nickname, $cidrs := $allowedAddresses }}
  # {{ $nickname }}
  {{- range $cidr := $cidrs }}
  - {{ $cidr }}
  {{- end -}}
  {{- end -}}
{{- end }}
