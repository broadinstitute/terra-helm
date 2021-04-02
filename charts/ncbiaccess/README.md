# ncbiaccess

Chart for NCBI Access service in Terra

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.applicationVersion | string | `"latest"` | What version of the Sam application to deploy |
| imageConfig.imagePullPolicy | string | `"Always"` |  |
| imageConfig.repository | string | `"broadinstitute/ncbiaccess"` | Image repo to use |
| imageConfig.tag | string | global.applicationVersion | Image tag to run |
| name | string | `"ncbiaccess"` | prefix for k8s resource names |
| replicas | int | `1` | number of pods to run |
| resources.limits.cpu | int | `1` |  |
| resources.limits.memory | string | `"2Gi"` |  |
| resources.requests.cpu | int | `1` |  |
| resources.requests.memory | string | `"2Gi"` |  |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
