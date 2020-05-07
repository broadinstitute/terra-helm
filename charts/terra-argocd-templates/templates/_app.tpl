{{- define "terra-argocd.app" -}}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: {{ required "A valid app name is required" .app }}-{{ required "A valid environment is required" .environment }}
  labels:
    app: {{ .app }} # These labels are used as selectors in the UI
    env: {{ .environment }}
    cluster: {{ .cluster }}
spec:
  project: {{ include "terra-argocd.projectName" . }}
  destination:
    namespace: {{ include "terra-argocd.destinationNamespace" . }}
    server: {{ include "terra-argocd.clusterAddress" . }}
  source:
    repoURL: {{ .helmfileRepo }}
    path: .
    plugin:
      name: helmfile
      env:
      - name: HELMFILE_ENV
        value: {{ .environment }}
      - name: HELMFILE_SELECTOR
        value: group=app,name={{ .app }}
{{- if .legacyConfigsEnabled }}
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: {{ .app }}-configs-{{ .environment }}
  labels:
    app: {{ .app }} # These labels are used as selectors in the UI
    env: {{ .environment }}
    cluster: {{ .cluster }}
spec:
  project: {{ include "terra-argocd.projectName" . }}
  destination:
    namespace: {{ include "terra-argocd.destinationNamespace" . }}
    server: {{ include "terra-argocd.clusterAddress" . }}
  source:
    repoURL: {{ .legacyConfigsRepo }}
    targetRevision: {{ .legacyConfigsRepoRef }}
    path: .
    plugin:
      name: legacy-configs
      env:
      {{- $instanceTypes := .legacyConfigsInstanceTypes | join "," -}}
      {{- $envVars := merge .legacyConfigsEnv (dict "ENV" .environment "APP_NAME" .app "INSTANCE_TYPES" $instanceTypes ) -}}
      {{- range $name, $value := $envVars }}
      - name: {{ $name }}
        value: {{ $value }}
      {{- end -}}
  {{- end -}}
{{- end -}}
