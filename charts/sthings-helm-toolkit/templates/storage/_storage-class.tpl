{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $storageClassName, $storageClassTpl := .Values.scs -}}
{{ include "sthings-helm-toolkit.storageClass" (list $envVar $storageClassName $storageClassTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.storageclass" -}}
{{- $envVar := first . -}}
{{- $storageclassName := index . 1 -}}
{{- $storageclass := index . 2 -}}
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: {{ $storageclass.name }}
{{- if $storageclass.annotations }}
  annotations:
  {{- range $key, $value := $storageclass.annotations }}
    {{ $key }}: {{ $value | quote }}
{{- end }}{{- end }}
provisioner: {{ $storageclass.provisioner }}
{{- if $storageclass.parameters }}
parameters:
  {{- toYaml $storageclass.parameters | nindent 2 }}
{{- end }}{{- end }}

{{/*
# exampleValues:
examples:
  - name: basic-storage-class
    values: |
      scs:
        ontap:
          name: ontap
          annotations:
            storageclass.beta.kubernetes.io/is-default-class: "true"
            storageclass.kubernetes.io/is-default-class: "true"
          provisioner: netapp.io/trident
          parameters:
          backendType: ontap-nas
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2023
*/}}
