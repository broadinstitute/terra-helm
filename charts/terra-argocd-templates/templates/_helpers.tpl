{{/* vim: set filetype=mustache: */}}
{{/*
What name to use for a project
*/}}
{{- define "terra-argocd.projectName" -}}
terra-{{ required "A valid environment value is required" .environment }}
{{- end -}}

{{/*
Which namespace to deploy to
*/}}
{{- define "terra-argocd.destinationNamespace" -}}
terra-{{ required "A valid environment value is required" .environment }}
{{- end -}}

{{/*
Which cluster to deploy to
*/}}
{{- define "terra-argocd.clusterAddress" -}}
{{- $cluster := required "A valid cluster value is required" .cluster -}}
{{- $clusters := required "A valid clusters map is required" .clusters -}}
{{ required (printf "Cluster %s is not defined in cluster map" $cluster) (index $clusters $cluster) -}}
{{- end -}}
