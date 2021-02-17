{{- /* Use underscore to avoid conflicting with Bitnami helpers */ -}}
{{- define "_mongodb.image" -}}
  {{- required "A valid .Values.bitnami.image.registry value is required!" .Values.bitnami.image.registry -}}
  /
  {{- required "A valid .Values.bitnami.image.repository value is required!" .Values.bitnami.image.repository -}}
  :
  {{- required "A valid .Values.bitnami.image.tag value is required!" .Values.bitnami.image.tag -}}
{{- end -}}

{{- /* Use underscore to avoid conflicting with Bitnami helpers */ -}}
{{- define "_mongodb.backup.cloudsdk.image" -}}
  {{- required "A valid .Values.backup.cloudsdkImage.repository value is required!" .Values.backup.cloudsdkImage.repository -}}
  :
  {{- required "A valid .Values.backup.cloudsdkImage.tag value is required!" .Values.backup.cloudsdkImage.tag -}}
{{- end -}}

{{- /*
Craft a MongoDB replicaset connection url for use by backup job. Eg.
   mongodb://root@mongodb-0.mongodb-headless:27017,mongodb-1.mongodb-headless:27017,mongodb-2.mongodb-headless:27017/?replicaSet=rs0
*/ -}}
{{- define "_mongodb.backup.replicaset.url" -}}
  {{- $user := "root"                            -}}{{- /* user to connect as */ -}}
  {{- $svc  := printf "%s-headless" .Values.name -}}{{- /* name of MongoDB headless service */ -}}
  {{- $sts  := printf .Values.name               -}}{{- /* name of MongoDB statefulset */ -}}
  {{- $port := 27017                             -}}{{- /* port MongoDB is listening */ -}}
  {{- $rs   := "rs0"                             -}}{{- /* replica set identifier */ -}}

  {{- /* Build dictionary of server names */ -}}
  {{- $serverdict := dict -}}
  {{- range $index, $_ := until (int .Values.bitnami.replicaCount) -}}
    {{- $name := printf "%s-%d.%s:%d" $sts $index $svc $port -}}
    {{- $_ := set $serverdict $name true -}}
  {{- end -}}

  {{- /* Join server names into comma-separated string */ -}}
  {{- $servers := keys $serverdict | sortAlpha | join "," -}}

  mongodb://{{ $user }}@{{ $servers }}/?replicaSet={{ $rs -}}
{{- end -}}
