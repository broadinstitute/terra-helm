{{/*
AoU Preprod Conditional
*/}}
{{- define "externalcreds.aoupreprodconditional" -}}
  ((.email|endswith("@preprod.researchallofus.org")) and (.audience as $idkey | "${AOU_PREPROD_ALLOWLIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
AoU Perf Conditional
*/}}
{{- define "externalcreds.aouperfconditional" -}}
  ((.email|endswith("@perf.fake-research-aou.org")) and (.audience as $idkey | "${AOU_PERF_ALLOWLIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
AoU Prod Conditional
*/}}
{{- define "externalcreds.aouprodconditional" -}}
  ((.email|endswith("@researchallofus.org")) and (.audience as $idkey | "${AOU_PROD_ALLOWLIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
AoU Dev Conditional
*/}}
{{- define "externalcreds.aoudevconditional" -}}
  ((.email|endswith("@fake-research-aou.org")) and (.audience as $idkey | "${AOU_DEV_ALLOWLIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
AoU Stable Conditional
*/}}
{{- define "externalcreds.aoustableconditional" -}}
  ((.email|endswith("@stable.fake-research-aou.org")) and (.audience as $idkey | "${AOU_STABLE_ALLOWLIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
AoU Staging Conditional
*/}}
{{- define "externalcreds.aoustagingconditional" -}}
  ((.email|endswith("@staging.fake-research-aou.org")) and (.audience as $idkey | "${AOU_STAGING_ALLOWLIST}" | split(",") | map(. as $element | $idkey | startswith($element))))
{{- end }}
{{/*
Terra ID Allowlist
*/}}
{{- define "externalcreds.terraidallowlist" -}}
  (.audience as $idkey | "${TERRA_ID_ALLOWLIST}" | split(",") | map(. as $element | $idkey | startswith($element)))
{{- end }}
{{/*
Terra Conditional
*/}}
{{- define "externalcreds.terraconditional" -}}
  (((.email|endswith("@researchallofus.org")|not) and (.email|endswith("@preprod.researchallofus.org")|not) and (.email|endswith("@staging.fake-research-aou.org")|not) and (.email|endswith("@stable.fake-research-aou.org")|not) and (.email|endswith("@perf.fake-research-aou.org")|not) and (.email|endswith("@fake-research-aou.org")|not)) and {{ template "externalcreds.terraidallowlist" . }})
{{- end }}
