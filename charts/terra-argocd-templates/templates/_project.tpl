{{- define "terra-argocd.project" -}}
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: {{ include "terra-argocd.projectName" . }}
spec:
  description: "Applications for Terra {{ .environment }} environment"
  destinations:
  - namespace: {{ include "terra-argocd.destinationNamespace" . }}
    server: {{ include "terra-argocd.clusterAddress" . }}
  sourceRepos:
  - "*"
{{- end -}}
