{{/*
Expand the name of the chart.
*/}}
{{- define "poc.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 56 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "poc.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 56 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create labels to use for resources in this chart
*/}}
{{- define "poc.labels" -}}
labels:
  helm.sh/chart: {{ template "poc.chart" . }}
  app.kubernetes.io/name: {{ template "poc.name" . }}
  app.kubernetes.io/instance: {{ .Release.Name | quote }}
  app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
  app.kubernetes.io/component: poc
  app.kubernetes.io/part-of: terra
{{- end -}}
