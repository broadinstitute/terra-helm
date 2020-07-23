postgres
========

Library chart for an ephemeral PostgreSQL database container



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appVersion | string | `"12"` | (string) Service image version/tag |
| dbs | list | `[]` | (array(string)) List of additional databases to create.  |
| imageConfig.imagePullPolicy | string | `"Always"` | Image pull policy |
| imageConfig.repository | string | `"postgres"` | Image repository |
| imageConfig.tag | string | The chart's appVersion value will be used | Image tag |
| password | string | `"postgres"` | Default postgres user password |
