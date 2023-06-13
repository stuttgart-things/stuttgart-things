{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $secretName, $secretTpl := .Values.gitSecretsBasicAuth -}}
{{ include "sthings-helm-toolkit.gitBasicAuthSecret" (list $envVar $secretName $secretTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.gitBasicAuthSecret" -}}
{{- $envVar := first . -}}
{{- $gitBasicAuthSecretName := index . 1 -}}
{{- $gitBasicAuthSecret := index . 2 -}}
---
kind: Secret
apiVersion: v1
metadata:
  name: {{ $gitBasicAuthSecretName }}
  namespace: {{ $gitBasicAuthSecret.namespace | default $envVar.Values.namespace }}
{{- if $gitBasicAuthSecret.annotations }}
  annotations:
  {{- range $key, $value := $gitBasicAuthSecret.annotations }}
    {{ $key }}: {{ $value | quote }}
{{- end }}{{- end }}
{{- if $gitBasicAuthSecret.labels }}
  labels:
    {{- toYaml $gitBasicAuthSecret.labels | nindent 4  }}{{- end }}
type: Opaque
stringData:
  .gitconfig: |
    [credential "https://{{ $gitBasicAuthSecret.hostname }}"]
      helper = store
  .git-credentials: |
    https://{{ $gitBasicAuthSecret.username }}:{{ $gitBasicAuthSecret.password }}@{{ $gitBasicAuthSecret.hostname }}
{{- end }}

{{/*
# exampleValues:
---
gitSecretsBasicAuth:
  codehub-basicauth:
    # annotations:
    #   argocd.argoproj.io/sync-wave: "0"
    labels:
      app: sthings-tekton
    namespace: tekton-cicd
    hostname: codehub.sva.de
    username: <path:git/data/codehub#git_token_username>
    password: <path:git/data/codehub#git_token_password>
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
