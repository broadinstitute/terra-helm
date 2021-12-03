{{- /*
Abstract common yaml between deployment.yaml and job.yaml
*/ -}}
{{- define "revere.podSpec" -}}
serviceAccountName: {{ .Values.global.name }}-sa

{{- with .Values.nodeSelector }}
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
- name: {{ .Values.global.name }}-cm
  configMap:
    name: {{ .Values.global.name }}-cm
{{- if .Values.secrets.gcpServiceAccount.secretsManager.enabled }}
- name: {{ .Values.global.name }}-gcp-sa
  secret:
    secretName: {{ .Values.global.name }}-gcp-sa
{{- end }}

containers:
- name: {{ .Values.global.name }}-app
  image: "{{ .Values.imageConfig.repository }}:{{ .Values.imageConfig.tag | default .Values.global.applicationVersion }}"
  imagePullPolicy: {{ .Values.imageConfig.imagePullPolicy }}
  resources:
    {{- toYaml .Values.resources | nindent 4 }}

  env:
  - name: REVERE_STATUSPAGE_APIKEY
    valueFrom:
      secretKeyRef:
        name: {{ .Values.global.name }}-statuspage-api-key
        key: statuspageApiKey
  {{- if .Values.secrets.gcpServiceAccount.secretsManager.enabled }}
  - name: GOOGLE_APPLICATION_CREDENTIALS
    value: /etc/revere-sa/serviceAccount.json
  {{- end }}

  volumeMounts:
  - mountPath: /etc/revere/revere.yaml
    name: {{ .Values.global.name }}-cm
    readOnly: true
    subPath: revere.yaml
  {{- if .Values.secrets.gcpServiceAccount.secretsManager.enabled }}
  - mountPath: /etc/revere-sa/
    name: {{ .Values.global.name }}-gcp-sa
    readOnly: true
  {{- end }}
{{- end -}}