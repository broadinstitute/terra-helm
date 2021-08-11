{{- /*
ingresslibchart.util.merge will merge two YAML templates and output the result.
This takes an array of three values:
- the top context
- the template name of the overrides (destination)
- the template name of the base (source)
*/}}
{{- define "ingresslibchart.util.merge" -}}
{{- $top := first . -}}
{{- $overrides := fromYaml (include (index . 1) $top) | default (dict ) -}}
{{- $tpl := fromYaml (include (index . 2) $top) | default (dict ) -}}
{{- toYaml (merge $overrides $tpl) -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "helm.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Values.name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: {{ .Chart.Name }}
app.kubernetes.io/part-of: terra
{{- end }}
