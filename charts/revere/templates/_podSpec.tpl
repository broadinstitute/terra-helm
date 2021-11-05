{{- /*
Abstract common yaml between deployment.yaml and job.yaml
*/ -}}
{{- define "revere.podSpec" -}}
serviceAccountName: {{ .Values.name }}-sa

nodeSelector:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.affinity }}
affinity:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.tolerations }}
tolerations:
  {{- toYaml . | nindent 2 }}
{{- end }}

volumes:
- name: {{ .Values.name }}-cm
  configMap:
    name: {{ .Values.name }}-cm
{{- if .Values.secrets.gcpServiceAccount.secretsManager.enabled }}
- name: {{ .Values.name }}-gcp-sa
  secret:
    secretName: {{ .Values.name }}-gcp-sa
{{- end }}

containers:
- name: {{ .Values.name }}-app
  image: "{{ .Values.imageConfig.repository }}:{{ .Values.imageConfig.tag | default .Values.global.applicationVersion }}"
  imagePullPolicy: {{ .Values.imageConfig.imagePullPolicy }}
  resources:
    {{- toYaml .Values.resources | nindent 4 }}

  env:
  - name: REVERE_STATUSPAGE_APIKEY
    valueFrom:
      secretKeyRef:
        name: {{ .Values.name }}-statuspage-api-key
        key: statuspageApiKey
  {{- if .Values.secrets.gcpServiceAccount.secretsManager.enabled }}
  - name: GOOGLE_APPLICATION_CREDENTIALS
    value: /etc/revere-sa/serviceAccount.json
  {{- end }}

  volumeMounts:
  - mountPath: /etc/revere/revere.yaml
    name: {{ .Values.name }}-cm
    readOnly: true
    subPath: revere.yaml
  {{- if .Values.secrets.gcpServiceAccount.secretsManager.enabled }}
  - mountPath: /etc/revere-sa/
    name: {{ .Values.name }}-gcp-sa
    readOnly: true
  {{- end }}
{{- end -}}