{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $pvcName, $pvcTpl := .Values.pvcs -}}
{{ include "sthings-helm-toolkit.pvc" (list $envVar $pvcName $pvcTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.pvc" -}}
{{- $envVar := first . -}}
{{- $pvcName := index . 1 -}}
{{- $pvcTpl := index . 2 -}}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ $pvcName }}
  namespace: {{ $pvcTpl.namespace | default $envVar.Values.defaultNamespace }}
{{- if $pvcTpl.annotations }}
  annotations:
  {{- range $key, $value := $pvcTpl.annotations }}
    {{ $key }}: {{ $value | quote }}
{{- end }}{{- end }}
spec:
  storageClassName: {{ $pvcTpl.storageClassName }}
  accessModes:
  {{- range $pvcTpl.accessModes }}
    - {{ . }}
  {{- end }}
  volumeMode: {{ $pvcTpl.volumeMode }}
  resources:
    requests:
      storage: {{ $pvcTpl.storage }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: basic-pvc
    values: |
      pvcs:
        sthings-kaniko-workspace:
          #  annotations:
          #    argocd.argoproj.io/sync-wave: "0"
          volumeMode: Filesystem
          namespace: sthings-tekton
          storageClassName: ontap
          storage: 5Gi
          accessModes:
            - ReadWriteOnce
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
