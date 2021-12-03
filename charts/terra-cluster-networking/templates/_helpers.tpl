{{/*
Expand the name of the chart.
*/}}
{{- define "terra-cluster-networking.name" -}}
{{- default .Chart.Name .Values.global.nameOverride | trunc 56 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "terra-cluster-networking.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 56 | trimSuffix "-" -}}
{{- end -}}
