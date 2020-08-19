DUOS Ontology
========
A Helm chart for DUOS Ontology, the DUOS Algorithmic Matching System

Current chart version is `0.1.0`

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.applicationVersion | string | Is set by Helmfile on deploy | Ontology global version |
| devDeploy | bool | `false` | Enable to deploy to dev locally with Skaffold |
| elasticSearchServer1 | string | `nil` | first elastic search host |
| elasticSearchServer2 | string | `nil` | second elastic search host |
| elasticSearchServer3 | string | `nil` | third elastic search host |
| environment | string | `nil` | Environment, [dev, alpha, staging, prod] |
| gcsAccountPath | string | `nil` | Vault path to GCS base64 service account json |
| gcsAccountKey | string | `nil` | Vault key of GCS base64 service account json |
| googleBucket | string | `nil` | Google project where GCS files are stored |
| googleBucketSubdirectory | string | `nil` | Google bucket subdirectory |
| image | string | `nil` | If specified, overrides the GCR image location |
| imageConfigRepository | string | `nil` | GCR image location |
| imageConfigTag | string | `nil` | GCR image tag |
| proxyLogLevel | string | `"debug"` | Proxy log level |
| proxyImageRepository | string | `"broadinstitute/openidc-proxy"` | Proxy image repository |
| proxyImageVersion | string | `"bernick_tcell"` | Proxy image tag |
| sentryDsnPath | string | `nil` | Vault path to secret containing Sentry DSN value |
| sentryDsnKey | string | `nil` | Vault key of secret containing Sentry DSN value |
| vaultCertPath | string | `nil` | Path to secret containing .crt |
| vaultCertSecretKey | string | `nil` | Key in secret containing .crt |
| vaultKeyPath | string | `nil` | Path to secret containing .key |
| vaultKeySecretKey | string | `nil` | Key in secret containing .key |
| vaultChainPath | string | `nil` | Path to secret containing intermediate .crt |
| vaultChainSecretKey | string | `nil` | Key in secret containing intermediate .crt |

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

Convert standard vault json secret to a k8s friendly base64 text file:.
```
vault read -format=json secret/path/secret.json | jq '.data' | base64 -o base64.txt
```  
Decide on a new secret path and create it:
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