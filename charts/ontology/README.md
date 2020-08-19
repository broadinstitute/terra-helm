DUOS Ontology
========
A Helm chart for DUOS Ontology, the DUOS Algorithmic Matching System

Current chart version is `0.1.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.applicationVersion | string | Is set by Helmfile on deploy | Ontology global version |
| devDeploy | bool | `false` | Enable to deploy to dev locally with Skaffold |
| elasticSearch.server1 | string | `nil` | first elastic search host |
| elasticSearch.server2 | string | `nil` | second elastic search host |
| elasticSearch.server3 | string | `nil` | third elastic search host |
| environment | string | `nil` | Environment, [dev, staging, prod] |
| gcsAccount.path | string | `nil` | Vault path to GCS base64 service account json |
| gcsAccount.key | string | `nil` | Vault key of GCS base64 service account json |
| google.bucket | string | `nil` | Google project where GCS files are stored |
| google.subdirectory | string | `nil` | Google bucket subdirectory |
| imageConfig.repository | string | `nil` | GCR image location |
| imageConfig.tag | string | `nil` | GCR image tag |
| proxy.logLevel | string | `"debug"` | Proxy log level |
| proxy.image.repository | string | `"broadinstitute/openidc-proxy"` | Proxy image repository |
| proxy.image.version | string | `"bernick_tcell"` | Proxy image tag |
| sentry.dsn.path | string | `nil` | Vault path to secret containing Sentry DSN value |
| sentry.dsn.key | string | `nil` | Vault key of secret containing Sentry DSN value |
| vault.enabled | bool | `true` | When enabled, syncs required secrets from Vault |
| vault.pathPrefix | string | `nil` | Vault path prefix for secrets. Required if vault.enabled. |
| vaultCert.enabled | bool | `false` | Enable to sync certificate secret from Vault with secrets-manager |
| vaultCert.cert.path | string | `nil` | Path to secret containing .crt |
| vaultCert.cert.secretKey | string | `nil` | Key in secret containing .crt |
| vaultCert.key.path | string | `nil` | Path to secret containing .key |
| vaultCert.key.secretKey | string | `nil` | Key in secret containing .key |
| vaultCert.chain.path | string | `nil` | Path to secret containing intermediate .crt |
| vaultCert.chain.secretKey | string | `nil` | Key in secret containing intermediate .crt |

## Cheat Sheet

* `gcloud container clusters get-credentials terra-dev --zone us-central1-a --project broad-dsde-dev`
* `k get secrets -n terra-dev`
* `k describe secret ontology-secrets -n terra-dev`
* `k get configmap -n terra-dev`
* `k describe configmap ontology-configmap -n terra-dev`
* `helmfile -e dev --selector group=terra,app=ontology template`

## Storing JSON Secrets in Vault
Our k8s json secrets in vault are first base64 encoded and then written to 
the path. To pull them back out, we pull them using secrets.yaml and 
base64 decode them before writing to the pod's file system.

To convert our standard vault secrets to k8s friendly base64 versions, do this.
```
vault read -format=json secret/path/secret.json | jq '.data' | base64 -o base64.txt
```  
Decide on a new secret path and create it like this:
```
docker run -it --rm \
    -v $HOME:/root \
    broadinstitute/dsde-toolbox:dev vault-edit secret/path/secret-k8s.json
```
That drops you into vim. Edit the file to look like:
```
{ "key": "<paste contents of base64.txt>" }
```
and save. Now you can refer to this in your `secrets.yaml` like so
```
...
    secret-k8s.json:
      path: secret/path/secret-k8s.json
      encoding: base64
      key: key
...
```