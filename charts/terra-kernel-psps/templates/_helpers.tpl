{{/*
Expand the name of the chart.
*/}}
{{- define "terra-kernel-psps.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 56 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "terra-kernel-psps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 56 | trimSuffix "-" -}}
{{- end -}}
