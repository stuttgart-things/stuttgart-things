{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $customResourceName, $customResourceTpl := .Values.customresources -}}
{{ include "sthings-helm-toolkit.customResource" (list $envVar $customResourceName $customResourceTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.customResource" -}}
{{- $envVar := first . -}}
{{- $customResourceName := index . 1 -}}
{{- $customResource := index . 2 -}}
---
apiVersion: {{ $customResource.apiVersion }}
kind: {{ $customResource.kind }}
metadata:
  name: {{ $customResource.metadata.name }}
  namespace: {{ $customResource.metadata.namespace | default $envVar.Values.defaultNamespace }}
  labels:
    {{- toYaml $customResource.metadata.labels | nindent 4 }}
spec:
  {{- toYaml $customResource.spec| nindent 2 }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: metallb-config
    values: |
      customresources:
        addresspool:
          apiVersion: metallb.io/v1beta1
          kind: IPAddressPool
          metadata:
            name: ip-pool
            namespace: metallb-system
            labels:
              app: sthings-tekton
          spec:
            addresses:
            - 10.100.136.210-10.100.136.212
*/}}


{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
