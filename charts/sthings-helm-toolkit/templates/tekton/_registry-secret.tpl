{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $registrySecretName, $registrySecretSecretTpl := .Values.registryCredentials -}}
{{ include "sthings-helm-toolkit.registrySecret" (list $envVar $registrySecretName $registrySecretSecretTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.registrySecret" -}}
{{- $envVar := first . -}}
{{- $registrySecretName := index . 1 -}}
{{- $registrySecret := index . 2 -}}
{{- $registryUrl := $registrySecret.registry }}
{{- $registryUser := $registrySecret.username }}
{{- $registryPassword := $registrySecret.password }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $registrySecretName }}
  namespace: {{ $registrySecret.namespace | default $envVar.Values.namespace }}
{{- if $registrySecret.annotations }}
  annotations:
  {{- range $key, $value := $registrySecret.annotations }}
    {{ $key }}: {{ $value | quote }}
{{- end }}{{- end }}
data:
{{- if $registrySecret.dockerConfigJson }}
  config.json: {{ $registrySecret.dockerConfigJson }}
{{ else }}
  config.json: {{ include "sthings-helm-toolkit.dockerConfigJson" (list $registryUrl $registryUser $registryPassword) }}
{{- end }}
{{- end }}

{{/*
# exampleValues:
registryCredentials:
  scr-labda:
    registry: scr.tiab.labda.sva.de
    namespace: tekton-cicd
    dockerConfigJson: <path:harbor/data/scr#dockerConfigJson> # argocd lookup or just a b64 string
  scr-labul:
    namespace: tekton-cicd
    labels:
      app: sthings-tekton
    registry: scr.labul.sva.de
    username: sthings # or username
    password: secret # + pw instead of dockerConfigJson variable
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}