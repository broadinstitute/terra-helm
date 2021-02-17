{{- /* Configuration file for diskmanager */ -}}
{{- define "diskmanager.config" -}}
targetAnnotation: {{ .Values.config.targetAnnotation }}
googleProject: {{ .Values.config.googleProject }}
region: {{ .Values.config.region }}
zone: {{ .Values.config.zone}}
{{ end -}}