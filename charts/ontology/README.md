# ontology

A Helm chart for DUOS Ontology, the DUOS Algorithmic Matching System

![Version: 0.8.0](https://img.shields.io/badge/Version-0.7.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| devDeploy | bool | `false` |  |
| elasticSearchServer1 | string | `nil` |  |
| elasticSearchServer2 | string | `nil` |  |
| elasticSearchServer3 | string | `nil` |  |
| environment | string | `nil` |  |
| gcsAccountKey | string | `nil` |  |
| gcsAccountPath | string | `nil` |  |
| global.applicationVersion | string | `"latest"` | What version of the Ontology application to deploy |
| googleBucket | string | `nil` |  |
| googleBucketSubdirectory | string | `nil` |  |
| image | string | `nil` |  |
| imageRepository | string | `nil` |  |
| imageTag | string | `nil` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.liveness.spec.failureThreshold | int | `30` |  |
| probes.liveness.spec.httpGet.path | string | `"/status"` |  |
| probes.liveness.spec.httpGet.port | int | `8080` |  |
| probes.liveness.spec.initialDelaySeconds | int | `60` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `6` |  |
| probes.readiness.spec.httpGet.path | string | `"/status"` |  |
| probes.readiness.spec.httpGet.port | int | `8080` |  |
| probes.readiness.spec.initialDelaySeconds | int | `60` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `1` |  |
| proxyImageRepository | string | `nil` |  |
| proxyImageVersion | string | `nil` |  |
| proxyLogLevel | string | `nil` |  |
| replicas | int | `1` |  |
| sentryDsnKey | string | `nil` |  |
| sentryDsnPath | string | `nil` |  |
| serviceIP | string | `nil` | External IP of the service. Required. |
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
