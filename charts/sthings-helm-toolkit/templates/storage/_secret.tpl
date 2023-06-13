{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $secretName, $secretTpl := .Values.secrets -}}
{{ include "sthings-helm-toolkit.secret" (list $envVar $secretName $secretTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.secret" -}}
{{- $envVar := first . -}}
{{- $secretName := index . 1 -}}
{{- $secret := index . 2 -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secret.name }}
  namespace: {{ $secret.namespace | default $envVar.Values.namespace }}
{{- if $secret.annotations }}
  annotations:
  {{- range $key, $value := $secret.annotations }}
    {{ $key }}: {{ $value | quote }}
{{- end }}{{- end }}
{{- if $secret.labels }}
  labels:
    {{- toYaml $secret.labels | nindent 4  }}{{- end }}
type: {{ $secret.type | default "Opaque" }}
{{ $secret.dataType | default "stringData" }}:
{{- range $k, $v := $secret.secretKVs }}
  {{ $k }}: {{ $v | quote }}{{ end }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: basic-secret
    values: |
      secrets:
        msteams:
          name: msteams
          labels:
            app: sthings-tekton
          secretKVs:
            url: <path:apps/data/tekton#ms_teams_webhookurl> # argocd-vault-plugin reference
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
