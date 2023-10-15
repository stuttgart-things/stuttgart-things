{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $runName, $runTpl := .Values.runs -}}
{{ include "sthings-helm-toolkit.run" (list $envVar $runName $runTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.run" -}}
{{- $envVar := first . -}}
{{- $runName := index . 1 -}}
{{- $run := index . 2 -}}
---
apiVersion: tekton.dev/{{ $run.apiVersion | default "v1" }}
kind: {{ $run.kind | default "Pipeline" }}Run
metadata:
  name: {{ $run.name }}{{- if $run.addRandomDateToRunName }}-{{ now | date "060102-1504" }}{{- end }}
  namespace: {{ $run.namespace | default $envVar.Values.defaultNamespace }}
{{- if $run.annotations }}
  annotations:
  {{- range $key, $value := $run.annotations }}
    {{ $key }}: {{ $value | quote }}
{{- end }}{{- end }}
spec:
  {{ $run.kind | replace "Run" "" | lower | default "pipeline" }}Ref:
{{- if $run.ref }}
    name: {{ $run.ref }}
{{ else }}
    resolver: {{ $run.resolver }}
    params:
    {{- range $k, $v := $run.resolverParams }}
      - name: {{ $k }}
        value: {{ $v | quote -}}
    {{ end }}
{{ end }}
{{- if $run.taskRunSpecs }}
  taskRunSpecs:
  {{- if $run.taskRunSpecs.serviceAccounts }}
  {{- range $k, $v := $run.taskRunSpecs.serviceAccounts }}
    - pipelineTaskName: {{ $k }}
      serviceAccountName: {{ $v | quote -}}{{ end }}
  {{ end }}
{{ else }}
  workspaces:
  {{- range $k, $v := $run.workspaces }}
    - name: {{ $k }}
    {{- if eq $v.workspaceKind "csi" }}
      csi:
        driver: {{ $v.secretProviderDriver }}
        readOnly: true
        volumeAttributes:
          secretProviderClass: {{ $v.secretProviderClass }}{{ end }}
    {{- if eq $v.workspaceKind "volumeClaimTemplate" }}
      volumeClaimTemplate:
        spec:
          storageClassName: {{ $v.storageClassName }}
          accessModes:
          - {{ $v.accessModes }}
          resources:
            requests:
              storage: {{ $v.storage }}{{ end }}
  {{- if or (ne $v.workspaceKind "volumeClaimTemplate") }}{{- if or (ne $v.workspaceKind "csi") }}
    {{- if eq $v.workspaceKind "emptyDir" }}
      emptyDir: {}{{ else }}
      {{ $v.workspaceKind }}:
        {{ $v.workspaceKind | replace "persistentVolumeClaim" "claim" }}Name: {{ $v.workspaceRef }}{{ end }}{{ end }}
  {{ end }}{{ end }}
  params:
  {{- range $k, $v := $run.params }}
    - name: {{ $k }}
      value: {{ $v | quote -}}
  {{ end }}
  {{- if $run.listParams }}
  {{- range $k, $v := $run.listParams }}
    - name: {{ $k }}
      value:
      {{- range $v }}
        - {{ . | quote }}
      {{- end }}
  {{ end }}
  {{ end }}
{{- end }}

{{/*
# exampleValues:
# taskRun
runs:
  sendToMicrosoftTeams:
    name: send-to-microsoft-teams
    namespace: sthings-tekton
    kind: Task
    ref: send-msteams-webhook
    params:
      message: "Hello from Tekton!"
      webhook-url-secret: msteams
      webhook-url-secret-key: url
# pipelineRun
runs:
  buildKanikoImage:
    name: build-kaniko-image
    namespace: sthings-tekton
    kind: Pipeline
    ref: build-kaniko-image
    params:
      image: scr.tiab.labda.sva.de/sthings-argo/sthings-argo/
      gitRepoUrl: git@codehub.sva.de:Lab/stuttgart-things/stuttgart-things.git
      dockerfile: ./build/images/sthings-argo/Dockerfile
      context: ./build/images/sthings-argo/
    workspaces:
      ssh-credentials:
        workspaceKind: secret
        workspaceRef: codehub-ssh
      shared-workspace:
        workspaceKind: persistentVolumeClaim
        workspaceRef: sthings-kaniko-workspace
      dockerconfig:
        workspaceKind: secret
        workspaceRef: scr-labda
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
