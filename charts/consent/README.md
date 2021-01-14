DUOS Consent
========
A Helm chart for DUOS Consent

Current chart version is `0.1.0`

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| basicAuthPasswordKey | string | `nil` |  |
| basicAuthUserKey | string | `nil` |  |
| cloudSqlInstance | string | `nil` |  |
| confFilePath | string | `nil` |  |
| databasePasswordKey | string | `nil` |  |
| databaseUrl | string | `nil` |  |
| databaseUserKey | string | `nil` |  |
| devDeploy | bool | `false` |  |
| elasticSearchServer1 | string | `nil` |  |
| elasticSearchServer2 | string | `nil` |  |
| elasticSearchServer3 | string | `nil` |  |
| environment | string | `nil` |  |
| emailNotificationsEnabled | bool | `nil` |  |
| gcsAccountKey | string | `nil` |  |
| gcsAccountPath | string | `nil` |  |
| global.applicationVersion | string | `"latest"` | What version of the Ontology application to deploy |
| googleBucket | string | `nil` |  |
| googleBucketSubdirectory | string | `nil` |  |
| googleClientId | string | `nil` |  |
| googleProject | string | `nil` |  |
| googleProjectZone | string | `nil` |  |
| image | string | `nil` |  |
| imageRepository | string | `nil` |  |
| imageTag | string | `nil` |  |
| ingressIpName | string | `nil` | Global static ip for ingress. Required. | 
| proxyImageRepository | string | `nil` |  |
| proxyImageVersion | string | `nil` |  |
| proxyLogLevel | string | `nil` |  |
| replicas | int | `1` |  |
| sendgridApiKey | string | `nil` |  |
| sendgridApiKeyKey | string | `nil` |  |
| sentryDsnKey | string | `nil` |  |
| sentryDsnPath | string | `nil` |  |
| serviceIP | string | `nil` | External IP of the service. Required. |
| servicesLocalUrl | string | `nil` |  |
| servicesOntologyUrl | string | `nil` |  |
| vaultCertPath | string | `nil` |  |
| vaultCertSecretKey | string | `nil` |  |
| vaultChain | string | `nil` |  |
| vaultChainPath | string | `nil` |  |
| vaultChainSecretKey | string | `nil` |  |
| vaultEnabled | bool | `true` |  |
| vaultKeyPath | string | `nil` |  |
| vaultKeySecretKey | string | `nil` |  |

## Cheat Sheet

* `gcloud container clusters get-credentials terra-dev --zone us-central1-a --project broad-dsde-dev`
* `k get secrets -n terra-dev`
* `k describe secret consent-secrets -n terra-dev`
* `k get configmap -n terra-dev`
* `k describe configmap consent-configmap -n terra-dev`
* `helmfile -e dev --selector group=terra,app=consent template`

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