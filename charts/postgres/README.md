# postgres

Application chart for a Sam-specific PostgreSQL database container

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appVersion | string | `"12"` | (string) Service image version/tag |
| imageConfig.imagePullPolicy | string | `"Always"` | Image pull policy |
| imageConfig.repository | string | `"postgres"` | Image repository |
| imageConfig.tag | float | The chart's appVersion value will be used | (string) Image tag |
| name | string | `"postgres"` |  |
| serviceName | string | `"sam-postgres-service"` |  |
