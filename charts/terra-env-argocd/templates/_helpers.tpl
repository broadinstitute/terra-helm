{{/* vim: set filetype=mustache: */}}
{{/*
What name to use for the project
*/}}
{{- define "terra-env-argocd.projectName" -}}
terra-{{ required "A valid environment value is required" .Values.environment }}
{{- end -}}

{{/*
Which namespace to deploy to
*/}}
{{- define "terra-env-argocd.destinationNamespace" -}}
terra-{{ required "A valid environment value is required" .Values.environment }}
{{- end -}}

{{/*
Which cluster to deploy to
*/}}
{{- define "terra-env-argocd.clusterAddress" -}}
{{- $clusterName := required "A valid cluster value is required" .Values.cluster -}}
{{ required (printf "Unknown cluster %s, is it defined in values?" $clusterName) (index .Values.private.clusters $clusterName) }}
{{- end -}}
