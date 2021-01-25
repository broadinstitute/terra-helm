{{- define "duos.config.json" -}}
{
  "env": "{{ .Values.environment }}",
  "hash": "{{ .Values.global.applicationVersion }}",
  "tag": "{{ .Chart.AppVersion }}",
  "apiUrl": "{{ .Values.apiUrl }}",
  "ontologyApiUrl": "{{ .Values.ontologyApiUrl }}",
  "clientId": "{{ .Values.googleClientId }}",
  "errorApiKey": "{{ .Values.errorApiKey }}",
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
