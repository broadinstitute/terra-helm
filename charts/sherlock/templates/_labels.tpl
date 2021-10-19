{{- /*
Create labels to use for resources in this chart

See
https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/
*/ -}}
{{- define "sherlock.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Values.name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: sherlock
app.kubernetes.io/part-of: dsp
{{- end -}}
Selector labels
*/}}
{{- define "sherlock.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Values.name | quote }}
{{- end }}
