terra-cluster
=============

A Helm chart to install cluster-wide resources for Terra

## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://broadinstitute.github.io/datarepo-helm/ | install-secrets-manager | 0.0.6 |
| https://broadinstitute.github.io/terra-helm/ | terra-cluster-networking | 0.0.1 |
| https://broadinstitute.github.io/terra-helm/ | terra-cluster-psps | 0.1.0 |
| https://broadinstitute.github.io/terra-helm/ | terra-prometheus | 0.6.0 |
| https://broadinstitute.github.io/terra-helm | terra-cluster-storage | 0.2.0 |
| https://stakater.github.io/stakater-charts | reloader | v0.0.69 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| install-secrets-manager.enabled | bool | `true` |  |
| install-secrets-manager.existingRoleIdKey | string | `"role-id"` |  |
| install-secrets-manager.existingSecret | string | `"secret-manager-approle"` |  |
| install-secrets-manager.existingSecretIdKey | string | `"secret-id"` |  |
| install-secrets-manager.rbac.create | bool | `true` |  |
| install-secrets-manager.serviceAccount.create | bool | `true` |  |
| install-secrets-manager.vaultLocation | string | `"https://clotho.broadinstitute.org:8200"` |  |
| install-secrets-manager.vaultVersion | string | `"kv1"` |  |
| reloader.enabled | bool | `true` |  |
| reloader.reloader.serviceAccount.name | string | `"reloader"` |  |
| terra-cluster-networking.gateway.name | string | `"default-istio-gateway"` |  |
| terra-cluster-networking.namespaces.istio | string | `"istio-system"` |  |
| terra-cluster-psps.namespaces.istio | string | `"istio-system"` |  |
| terra-cluster-psps.namespaces.kubeStateMetrics | string | `"default"` |  |
| terra-cluster-psps.serviceAccounts.istio[0] | string | `"istio-citadel-service-account"` |  |
| terra-cluster-psps.serviceAccounts.istio[1] | string | `"istio-galley-service-account"` |  |
| terra-cluster-psps.serviceAccounts.istio[2] | string | `"istio-ingressgateway-service-account"` |  |
| terra-cluster-psps.serviceAccounts.istio[3] | string | `"istio-mixer-service-account"` |  |
| terra-cluster-psps.serviceAccounts.istio[4] | string | `"istio-multi"` |  |
| terra-cluster-psps.serviceAccounts.istio[5] | string | `"istio-pilot-service-account"` |  |
| terra-cluster-psps.serviceAccounts.istio[6] | string | `"istio-security-post-install-account"` |  |
| terra-cluster-psps.serviceAccounts.istio[7] | string | `"istio-sidecar-injector-service-account"` |  |
| terra-cluster-psps.serviceAccounts.istio[8] | string | `"promsd"` |  |
| terra-cluster-storage.enabled | bool | `true` |  |
| terra-prometheus.enabled | bool | `true` |  |
| terra-prometheus.kube-prometheus-stack.alertmanager.serviceMonitor.metricRelabelings[0].replacement | string | `"false"` |  |
| terra-prometheus.kube-prometheus-stack.alertmanager.serviceMonitor.metricRelabelings[0].sourceLabels[0] | string | `"__name__"` |  |
| terra-prometheus.kube-prometheus-stack.alertmanager.serviceMonitor.metricRelabelings[0].targetLabel | string | `"sd_export"` |  |
| terra-prometheus.kube-prometheus-stack.coreDns.enabled | bool | `false` |  |
| terra-prometheus.kube-prometheus-stack.defaultRules.rules.kubernetesApps | bool | `false` |  |
| terra-prometheus.kube-prometheus-stack.defaultRules.rules.kubernetesResources | bool | `false` |  |
| terra-prometheus.kube-prometheus-stack.defaultRules.rules.kubernetesSystem | bool | `false` |  |
| terra-prometheus.kube-prometheus-stack.defaultRules.rules.prometheus | bool | `false` |  |
| terra-prometheus.kube-prometheus-stack.defaultRules.rules.prometheusOperator | bool | `false` |  |
| terra-prometheus.kube-prometheus-stack.grafana.serviceMonitor.metricRelabelings[0].replacement | string | `"false"` |  |
| terra-prometheus.kube-prometheus-stack.grafana.serviceMonitor.metricRelabelings[0].sourceLabels[0] | string | `"__name__"` |  |
| terra-prometheus.kube-prometheus-stack.grafana.serviceMonitor.metricRelabelings[0].targetLabel | string | `"sd_export"` |  |
| terra-prometheus.kube-prometheus-stack.kube-state-metrics.namespaceOverride | string | `"monitoring"` |  |
| terra-prometheus.kube-prometheus-stack.kubeApiServer.serviceMonitor.metricRelabelings[0].replacement | string | `"false"` |  |
| terra-prometheus.kube-prometheus-stack.kubeApiServer.serviceMonitor.metricRelabelings[0].sourceLabels[0] | string | `"__name__"` |  |
| terra-prometheus.kube-prometheus-stack.kubeApiServer.serviceMonitor.metricRelabelings[0].targetLabel | string | `"sd_export"` |  |
| terra-prometheus.kube-prometheus-stack.kubeControllerManager.enabled | bool | `false` |  |
| terra-prometheus.kube-prometheus-stack.kubeDns.serviceMonitor.metricRelabelings[0].replacement | string | `"false"` |  |
| terra-prometheus.kube-prometheus-stack.kubeDns.serviceMonitor.metricRelabelings[0].sourceLabels[0] | string | `"__name__"` |  |
| terra-prometheus.kube-prometheus-stack.kubeDns.serviceMonitor.metricRelabelings[0].targetLabel | string | `"sd_export"` |  |
| terra-prometheus.kube-prometheus-stack.kubeEtcd.enabled | bool | `false` |  |
| terra-prometheus.kube-prometheus-stack.kubeProxy.enabled | bool | `false` |  |
| terra-prometheus.kube-prometheus-stack.kubeScheduler.enabled | bool | `false` |  |
| terra-prometheus.kube-prometheus-stack.kubeStateMetrics.serviceMonitor.metricRelabelings[0].replacement | string | `"false"` |  |
| terra-prometheus.kube-prometheus-stack.kubeStateMetrics.serviceMonitor.metricRelabelings[0].sourceLabels[0] | string | `"__name__"` |  |
| terra-prometheus.kube-prometheus-stack.kubeStateMetrics.serviceMonitor.metricRelabelings[0].targetLabel | string | `"sd_export"` |  |
| terra-prometheus.kube-prometheus-stack.kubelet.serviceMonitor.metricRelabelings[0].replacement | string | `"false"` |  |
| terra-prometheus.kube-prometheus-stack.kubelet.serviceMonitor.metricRelabelings[0].sourceLabels[0] | string | `"__name__"` |  |
| terra-prometheus.kube-prometheus-stack.kubelet.serviceMonitor.metricRelabelings[0].targetLabel | string | `"sd_export"` |  |
| terra-prometheus.kube-prometheus-stack.namespaceOverride | string | `"monitoring"` |  |
| terra-prometheus.kube-prometheus-stack.nodeExporter.serviceMonitor.metricRelabelings[0].replacement | string | `"false"` |  |
| terra-prometheus.kube-prometheus-stack.nodeExporter.serviceMonitor.metricRelabelings[0].sourceLabels[0] | string | `"__name__"` |  |
| terra-prometheus.kube-prometheus-stack.nodeExporter.serviceMonitor.metricRelabelings[0].targetLabel | string | `"sd_export"` |  |
| terra-prometheus.kube-prometheus-stack.prometheus-node-exporter.namespaceOverride | string | `"monitoring"` |  |
| terra-prometheus.kube-prometheus-stack.prometheus.serviceMonitor.metricRelabelings[0].replacement | string | `"false"` |  |
| terra-prometheus.kube-prometheus-stack.prometheus.serviceMonitor.metricRelabelings[0].sourceLabels[0] | string | `"__name__"` |  |
| terra-prometheus.kube-prometheus-stack.prometheus.serviceMonitor.metricRelabelings[0].targetLabel | string | `"sd_export"` |  |
| terra-prometheus.kube-prometheus-stack.prometheusOperator.serviceMonitor.metricRelabelings[0].replacement | string | `"false"` |  |
| terra-prometheus.kube-prometheus-stack.prometheusOperator.serviceMonitor.metricRelabelings[0].sourceLabels[0] | string | `"__name__"` |  |
| terra-prometheus.kube-prometheus-stack.prometheusOperator.serviceMonitor.metricRelabelings[0].targetLabel | string | `"sd_export"` |  |
| terra-prometheus.namespaceOverride | string | `"monitoring"` |  |
