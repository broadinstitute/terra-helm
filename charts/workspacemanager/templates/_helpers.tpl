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

{{/*
LDAP base domain template
*/}}
{{- define "workspacemanager.ldapbasedomain" -}}
  dc=dsde-{{ .Values.global.terraEnv }},dc=broadinstitute,dc=org
{{- end }}

{{/*
AoU Preprod Conditional
*/}}
{{- define "workspacemanager.aoupreprodconditional" -}}
  ((.email|endswith("@preprod.researchallofus.org")) and (.audience | split(".")[0] as $idkey | "${AOU_PREPROD_WHITELIST}" | split(",") | any(contains($idkey))))
{{- end }}
{{/*
AoU Perf Conditional
*/}}
{{- define "workspacemanager.aouperfconditional" -}}
  ((.email|endswith("@perf.fake-research-aou.org")) and (.audience | split(".")[0] as $idkey | "${AOU_PERF_WHITELIST}" | split(",") | any(contains($idkey))))
{{- end }}
{{/*
AoU Prod Conditional
*/}}
{{- define "workspacemanager.aouprodconditional" -}}
  ((.email|endswith("@researchallofus.org")) and (.audience | split(".")[0] as $idkey | "${AOU_PROD_WHITELIST}" | split(",") | any(contains($idkey))))
{{- end }}
{{/*
AoU Dev Conditional
*/}}
{{- define "workspacemanager.aoudevconditional" -}}
  ((.email|endswith("@fake-research-aou.org")) and (.audience | split(".")[0] as $idkey | "${AOU_DEV_WHITELIST}" | split(",") | any(contains($idkey))))
{{- end }}
{{/*
AoU Stable Conditional
*/}}
{{- define "workspacemanager.aoustableconditional" -}}
  ((.email|endswith("@stable.fake-research-aou.org")) and (.audience | split(".")[0] as $idkey | "${AOU_STABLE_WHITELIST}" | split(",") | any(contains($idkey))))
{{- end }}
{{/*
AoU Staging Conditional
*/}}
{{- define "workspacemanager.aoustagingconditional" -}}
  ((.email|endswith("@staging.fake-research-aou.org")) and (.audience | split(".")[0] as $idkey | "${AOU_STAGING_WHITELIST}" | split(",") | any(contains($idkey))))
{{- end }}
{{/*
Terra ID Whitelist
*/}}
{{- define "workspacemanager.terraidwhitelist" -}}
  (.audience | split(".")[0] as $idkey | "${TERRA_ID_WHITELIST}" | split(",") | any(contains($idkey)))
{{- end }}
{{/*
Terra Conditional
*/}}
{{- define "workspacemanager.terraconditional" -}}
  (((.email|endswith("@researchallofus.org")|not) and (.email|endswith("@preprod.researchallofus.org")|not) and (.email|endswith("@staging.fake-research-aou.org")|not) and (.email|endswith("@stable.fake-research-aou.org")|not) and (.email|endswith("@perf.fake-research-aou.org")|not) and (.email|endswith("@fake-research-aou.org")|not)) and {{ template "workspacemanager.terraidwhitelist" . }})
{{- end }}
