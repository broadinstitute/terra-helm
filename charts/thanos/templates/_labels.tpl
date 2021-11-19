{{- /*
Create labels to use for resources in this chart

See
https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/
*/ -}}
{{- define "thanos.labels" -}}
helm.sh/chart: "{{ .Values.name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ .Values.name }}
app.kubernetes.io/instance: {{ .Values.name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: thanos
app.kubernetes.io/part-of: dsp-tools
{{- end -}}