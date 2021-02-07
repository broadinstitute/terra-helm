{{- /* Use underscore to avoid conflicting with Bitnami helpers */ -}}
{{- define "_mongodb.image" -}}
  {{- required "A valid .Values.bitnami.image.repository value is required!" .Values.bitnami.image.repository -}}
  {{- required "A valid .Values.bitnami.image.tag value is required!" .Values.bitnami.image.tag -}}"
{{- end -}}

{{- /* Use underscore to avoid conflicting with Bitnami helpers */ -}}
{{- define "_mongodb.backup.cloudsdk.image" -}}
  {{- required "A valid .Values.backup.cloudsdkImage.repository value is required!" .Values.backup.cloudsdkImage.repository -}}
  {{- required "A valid .Values.backup.cloudsdkImage.tag value is required!" .Values.backup.cloudsdkImage.tag -}}"
{{- end -}}
