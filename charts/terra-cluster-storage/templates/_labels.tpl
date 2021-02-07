{{- /*
Create labels to use for resources in this chart

See
https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/
*/ -}}
{{- define "terra-cluster-storage.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ .Release.Name }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: {{ .Chart.Name | quote }}
app.kubernetes.io/part-of: terra
{{- end -}}
