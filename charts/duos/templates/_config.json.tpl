{{- define "duos.config.json" -}}
{
  "env": "{{ .Values.environment }}",
  "apiUrl": "{{ .Values.apiUrl }}",
  "ontologyApiUrl": "{{ .Values.ontologyApiUrl }}",
  "clientId": "{{ .Values.googleClientId }}",
  "firecloudUrl": "{{ .Values.firecloudUrl }}",
  "gwasUrl": "{{ .Values.gwasUrl }}",
  "profileUrl": "{{ .Values.profileUrl }}",
  "nihUrl": "{{ .Values.nihUrl }}",
  "powerBiUrl": "{{ .Values.powerBiUrl }}",
  "gaId": "{{ .Values.gaId }}",
  "features": {
    "newDarUi": {{ .Values.newDarUi }}
  }
}
{{- end -}}
