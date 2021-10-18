{{/*
Create labels to use for resources in this chart
*/}}
{{- define "certManager.labels" }}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: cert-manager
app.kubernetes.io/part-of: dsp-tools
{{- end }}

{{/*
Shared logic for authenticating an issuer (or making sure that the issuer is already authenticated)
*/}}
{{- define "certManager.auth" }}
{{- if .Values.dnsProject.workloadIdentity }}
# dns-solver GCP SA associated via workload identity
{{- if not (hasKey (index .Values "cert-manager" "serviceAccount" "annotations") "iam.gke.io/gcp-service-account")}}
  {{- fail "If workloadIdentity is enabled, a service account annotation must be provided" }}
{{- end }}
{{- else }}
# used to access dns-solver GCP SA
serviceAccountSecretRef:
  name: {{ required "A valid .Values.dnsProject.serviceAccount.secretName value is required if workload identity is disabled" .Values.dnsProject.serviceAccount.secretName }}
  key: {{ required "A valid .Values.dnsProject.serviceAccount.secretKey is required if workload identity is disabled" .Values.dnsProject.serviceAccount.secretKey }}
{{- end }}
{{- end }}
