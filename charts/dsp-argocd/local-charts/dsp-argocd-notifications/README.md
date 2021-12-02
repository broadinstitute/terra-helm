# dsp-argocd-notifications

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Helm chart for deploying the DSP ArgoCD notifications instance

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| DSP DevOps | dsp-devops@broadinstitute.org |  |

## Source Code

* <https://github.com/broadinstitute/terra-helm/tree/master/charts/dsp-argocd-notifications>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://argoproj.github.io/argo-helm | upstream(argocd-notifications) | 1.4.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| name | string | `"dsp-argocd-notifications"` |  |
| upstream.argocdUrl | string | `"https://ap-argocd.dsp-devops.broadinstitute.org/"` |  |
| upstream.nameOverride | string | `"argocd-notifications"` |  |
| upstream.secret.create | bool | `false` |  |
| upstream.serviceAccount.name | string | `"argocd-notifications-controller"` |  |
| upstream.templates."template.app-deployed" | string | `"email:\n  subject: New version of an application {{.app.metadata.name}} is up and running.\nmessage: |\n  {{if eq .serviceType \"slack\"}}:white_check_mark:{{end}} Application {{.app.metadata.name}} is now running new version of deployments manifests.\nslack:\n  attachments: |\n    [{\n      \"title\": \"{{ .app.metadata.name}}\",\n      \"title_link\":\"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}\",\n      \"color\": \"#18be52\",\n      \"fields\": [\n      {\n        \"title\": \"Sync Status\",\n        \"value\": \"{{.app.status.sync.status}}\",\n        \"short\": true\n      },\n      {\n        \"title\": \"Repository\",\n        \"value\": \"{{.app.spec.source.repoURL}}\",\n        \"short\": true\n      },\n      {\n        \"title\": \"Revision\",\n        \"value\": \"{{.app.status.sync.revision}}\",\n        \"short\": true\n      }\n      {{range $index, $c := .app.status.conditions}}\n      {{if not $index}},{{end}}\n      {{if $index}},{{end}}\n      {\n        \"title\": \"{{$c.type}}\",\n        \"value\": \"{{$c.message}}\",\n        \"short\": true\n      }\n      {{end}}\n      ]\n    }]\n"` |  |
| upstream.templates."template.app-health-degraded" | string | `"email:\n  subject: Application {{.app.metadata.name}} has degraded.\nmessage: |\n  {{if eq .serviceType \"slack\"}}:exclamation:{{end}} Application {{.app.metadata.name}} has degraded.\n  Application details: {{.context.argocdUrl}}/applications/{{.app.metadata.name}}.\nslack:\n  attachments: |-\n    [{\n      \"title\": \"{{ .app.metadata.name}}\",\n      \"title_link\": \"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}\",\n      \"color\": \"#f4c030\",\n      \"fields\": [\n      {\n        \"title\": \"Sync Status\",\n        \"value\": \"{{.app.status.sync.status}}\",\n        \"short\": true\n      },\n      {\n        \"title\": \"Repository\",\n        \"value\": \"{{.app.spec.source.repoURL}}\",\n        \"short\": true\n      }\n      {{range $index, $c := .app.status.conditions}}\n      {{if not $index}},{{end}}\n      {{if $index}},{{end}}\n      {\n        \"title\": \"{{$c.type}}\",\n        \"value\": \"{{$c.message}}\",\n        \"short\": true\n      }\n      {{end}}\n      ]\n    }]\n"` |  |
| upstream.templates."template.app-sync-failed" | string | `"email:\n  subject: Failed to sync application {{.app.metadata.name}}.\nmessage: |\n  {{if eq .serviceType \"slack\"}}:exclamation:{{end}}  The sync operation of application {{.app.metadata.name}} has failed at {{.app.status.operationState.finishedAt}}\n  Sync operation details are available at: {{.context.argocdUrl}}/applications/{{.app.metadata.name}}?operation=true .\nslack:\n  attachments: |-\n    [{\n      \"title\": \"{{ .app.metadata.name}}\",\n      \"title_link\":\"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}\",\n      \"color\": \"#E96D76\",\n      \"fields\": [\n      {\n        \"title\": \"Sync Status\",\n        \"value\": \"{{.app.status.sync.status}}\",\n        \"short\": true\n      },\n      {\n        \"title\": \"Repository\",\n        \"value\": \"{{.app.spec.source.repoURL}}\",\n        \"short\": true\n      }\n      {{range $index, $c := .app.status.conditions}}\n      {{if not $index}},{{end}}\n      {{if $index}},{{end}}\n      {\n        \"title\": \"{{$c.type}}\",\n        \"value\": {{$c.message | toJson}},\n        \"short\": true\n      }\n      {{end}}\n      ]\n    }]\n"` |  |
| upstream.templates."template.app-sync-running" | string | `"email:\n  subject: Start syncing application {{.app.metadata.name}}.\nmessage: |\n  The sync operation of application {{.app.metadata.name}} has started at {{.app.status.operationState.startedAt}}.\n  Sync operation details are available at: {{.context.argocdUrl}}/applications/{{.app.metadata.name}}?operation=true .\nslack:\n  attachments: |-\n    [{\n      \"title\": \"{{ .app.metadata.name}}\",\n      \"title_link\":\"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}\",\n      \"color\": \"#0DADEA\",\n      \"fields\": [\n      {\n        \"title\": \"Sync Status\",\n        \"value\": \"{{.app.status.sync.status}}\",\n        \"short\": true\n      },\n      {\n        \"title\": \"Repository\",\n        \"value\": \"{{.app.spec.source.repoURL}}\",\n        \"short\": true\n      }\n      {{range $index, $c := .app.status.conditions}}\n      {{if not $index}},{{end}}\n      {{if $index}},{{end}}\n      {\n        \"title\": \"{{$c.type}}\",\n        \"value\": {{$c.message | toJson}},\n        \"short\": true\n      }\n      {{end}}\n      ]\n    }]\n"` |  |
| upstream.templates."template.app-sync-status-unknown" | string | `"email:\n  subject: Application {{.app.metadata.name}} sync status is 'Unknown'\nmessage: |\n  {{if eq .serviceType \"slack\"}}:exclamation:{{end}} Application {{.app.metadata.name}} sync is 'Unknown'.\n  Application details: {{.context.argocdUrl}}/applications/{{.app.metadata.name}}.\n  {{if ne .serviceType \"slack\"}}\n  {{range $c := .app.status.conditions}}\n      * {{$c.message}}\n  {{end}}\n  {{end}}\nslack:\n  attachments: |-\n    [{\n      \"title\": \"{{ .app.metadata.name}}\",\n      \"title_link\":\"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}\",\n      \"color\": \"#E96D76\",\n      \"fields\": [\n      {\n        \"title\": \"Sync Status\",\n        \"value\": \"{{.app.status.sync.status}}\",\n        \"short\": true\n      },\n      {\n        \"title\": \"Repository\",\n        \"value\": \"{{.app.spec.source.repoURL}}\",\n        \"short\": true\n      }\n      {{range $index, $c := .app.status.conditions}}\n      {{if not $index}},{{end}}\n      {{if $index}},{{end}}\n      {\n        \"title\": \"{{$c.type}}\",\n        \"value\": {{$c.message | toJson}},\n        \"short\": true\n      }\n      {{end}}\n      ]\n    }]\n"` |  |
| upstream.templates."template.app-sync-succeeded" | string | `"email:\n  subject: Application {{.app.metadata.name}} has been successfully synced.\nmessage: |\n  {{if eq .serviceType \"slack\"}}:white_check_mark:{{end}} Application {{.app.metadata.name}} has been successfully synced at {{.app.status.operationState.finishedAt}}.\n  Sync operation details are available at: {{.context.argocdUrl}}/applications/{{.app.metadata.name}}?operation=true .\nslack:\n  attachments: |-\n    [{\n      \"title\": \"{{ .app.metadata.name}}\",\n      \"title_link\": \"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}\",\n      \"color\": \"#18be52\",\n      \"fields\": [{\n        \"title\": \"Sync Status\",\n        \"value\": \"{{.app.status.sync.status}}\",\n        \"short\": true\n      },{\n        \"title\": \"Repository\",\n        \"value\": \"{{.app.spec.source.repoURL}}\",\n        \"short\": true\n      }\n      {{range $index, $c := .app.status.conditions}}\n      {{if not $index}},{{end}}\n      {{if $index}},{{end}}\n      {\n        \"title\": \"{{$c.type}}\",\n        \"value\": {{$c.message | toJson}},\n        \"short\": true\n      }\n      {{end}}\n      ]\n    }]\n"` |  |
| upstream.triggers."trigger.on-deployed" | string | `"- description: Application is synced and healthy. Triggered once per commit.\n  oncePer: app.status.sync.revision\n  send:\n  - app-deployed\n  when: app.status.operationState.phase in ['Succeeded'] and app.status.health.status == 'Healthy'\n"` |  |
| upstream.triggers."trigger.on-health-degraded" | string | `"- description: Application has degraded\n  send:\n  - app-health-degraded\n  when: app.status.health.status == 'Degraded'\n"` |  |
| upstream.triggers."trigger.on-sync-failed" | string | `"- description: Application syncing has failed\n  send:\n  - app-sync-failed\n  when: app.status.operationState.phase in ['Error', 'Failed']\n"` |  |
| upstream.triggers."trigger.on-sync-running" | string | `"- description: Application is being synced\n  send:\n  - app-sync-running\n  when: app.status.operationState.phase in ['Running']\n"` |  |
| upstream.triggers."trigger.on-sync-status-unknown" | string | `"- description: Application status is 'Unknown'\n  send:\n  - app-sync-status-unknown\n  when: app.status.sync.status == 'Unknown'\n"` |  |
| upstream.triggers."trigger.on-sync-succeeded" | string | `"- description: Application syncing has succeeded\n  send:\n  - app-sync-succeeded\n  when: app.status.operationState.phase in ['Succeeded']\n"` |  |
| vault.pathPrefix | string | `"secret/suitable/argocd/notifications"` |  |
| vault.secretName | string | `"dsp-argocd-notifications-secret"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)