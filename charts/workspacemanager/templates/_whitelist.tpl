{{/*
AoU Preprod Conditional
*/}}
{{- define "workspacemanager.aoupreprodconditional" -}}
  ((.email|endswith("@preprod.researchallofus.org")) and (.audience as $idkey | "${AOU_PREPROD_WHITELIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
AoU Perf Conditional
*/}}
{{- define "workspacemanager.aouperfconditional" -}}
  ((.email|endswith("@perf.fake-research-aou.org")) and (.audience as $idkey | "${AOU_PERF_WHITELIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
AoU Prod Conditional
*/}}
{{- define "workspacemanager.aouprodconditional" -}}
  ((.email|endswith("@researchallofus.org")) and (.audience as $idkey | "${AOU_PROD_WHITELIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
AoU Dev Conditional
*/}}
{{- define "workspacemanager.aoudevconditional" -}}
  ((.email|endswith("@fake-research-aou.org")) and (.audience as $idkey | "${AOU_DEV_WHITELIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
AoU Stable Conditional
*/}}
{{- define "workspacemanager.aoustableconditional" -}}
  ((.email|endswith("@stable.fake-research-aou.org")) and (.audience as $idkey | "${AOU_STABLE_WHITELIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
AoU Staging Conditional
*/}}
{{- define "workspacemanager.aoustagingconditional" -}}
  ((.email|endswith("@staging.fake-research-aou.org")) and (.audience as $idkey | "${AOU_STAGING_WHITELIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
Terra ID Whitelist
*/}}
{{- define "workspacemanager.terraidwhitelist" -}}
  (.audience as $idkey | "${TERRA_ID_WHITELIST}" | split(",") | map(. as $element | $idkey | startswith($element)))
{{- end }}
{{/*
Terra Conditional
*/}}
{{- define "workspacemanager.terraconditional" -}}
  (((.email|endswith("@researchallofus.org")|not) and (.email|endswith("@preprod.researchallofus.org")|not) and (.email|endswith("@staging.fake-research-aou.org")|not) and (.email|endswith("@stable.fake-research-aou.org")|not) and (.email|endswith("@perf.fake-research-aou.org")|not) and (.email|endswith("@fake-research-aou.org")|not)) and {{ template "workspacemanager.terraidwhitelist" . }})
{{- end }}
