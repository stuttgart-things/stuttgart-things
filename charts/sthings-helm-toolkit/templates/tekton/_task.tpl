{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $taskName, $taskTpl := .Values.tasks -}}
{{ include "sthings-helm-toolkit.task" (list $envVar $taskName $taskTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.task" -}}
{{- $envVar := first . -}}
{{- $taskName := index . 1 -}}
{{- $task := index . 2 -}}
---
apiVersion: tekton.dev/{{ $task.apiVersion | default "v1" }} 
kind: Task
metadata:
  name: {{ $taskName }}
  namespace: {{ $task.namespace | default $envVar.Values.defaultNamespace }}
  labels:
    {{- toYaml $task.labels | nindent 4 }}
  {{- if $task.annotations }}
  annotations:
  {{- range $key, $value := $task.annotations }}
    {{ $key }}: {{ $value | quote }}
  {{- end }}{{- end }}
spec:
  description: {{ $task.description }}
  {{- if $task.workspaces }}
  workspaces:
    {{- range $k, $v := $task.workspaces }}
    - name: {{ $k }}
      description: {{ $v.description }}
      optional: {{ $v.optional | default false }}
      {{- if $v.mountPath }}
      mountPath: {{ $v.mountPath }}
      {{- end }}{{ end }}
  {{- end }}
  params:
    {{- range $k, $v := $task.params }}
    - name: {{ $k }}
      description: {{ $v.description }}
      type: {{ $v.type | default "string" }}
      {{- if $v.default }}
      default: {{ $v.default | quote }}{{ else }}
      {{- if eq $v.type "array" }}
      default: []
      {{ else }}
      default: ""{{- end }}{{- end }}{{ end }}
  {{- if $task.results }}
  results:
    {{- range $k, $v := $task.results }}
    - name: {{ $k }}
      description: {{ $v.description }}
    {{- end }}
  {{- end }}
  steps:
  {{- range $k, $v := $task.steps }}
    - name: {{ $k }}
      {{- if $v.workingDir  }}
      workingDir: {{ $v.workingDir }}
      {{- end }}
      {{- if $v.command  }}
      command: [{{ $v.command | quote }}]
      {{- end }}
      {{- if $v.args }}
      args:
      {{- range $v.args }}
        - {{ . }}
      {{- end }}{{- end }}
      image: {{ $v.image | quote }}
      {{- if $v.env  }}
      env:
      {{- range $ke, $ve := $v.env }}
        - name: {{ $ke }}
        {{- if $ve.value  }}
          value: {{ $ve.value }}{{- end }}
        {{- if $ve.valueFrom }}
          valueFrom:{{ $ve.valueFrom | toYaml | nindent 12 }}{{- end }}
        {{- end }}
      {{- end }}
      {{- if $v.securityContext }}
      securityContext:
        runAsNonRoot: {{ $v.securityContext.runAsNonRoot }}
        runAsUser: {{ $v.securityContext.runAsUser }}
      {{- end }}
      {{- if $v.script }}
      script: {{- $v.script | toYaml | indent 6 | replace "     |" "|" }}
      {{- end }}
  {{- end }}
{{- end }}

{{/*
# exampleValues:
---
tasks:
  kaniko:
    namespace: sthings-tekton
    labels:
      app.kubernetes.io/version: "0.6"
    annotations:
      tekton.dev/pipelines.minVersion: "0.17.0"
      tekton.dev/categories: Image Build
      tekton.dev/tags: image-build
      tekton.dev/displayName: "Build and upload container image using Kaniko"
      tekton.dev/platforms: "linux/amd64"
    description: build Dockerfile w/ kaniko and pushe to a registry
    workspaces:
      source:
        description: holds the context and Dockerfile
        optional: false
      dockerconfig:
        description: includes a docker `config.json`
        optional: true
        mountPath: /kaniko/.docker
    results:
      IMAGE_DIGEST:
        description: digest of the image just built
      IMAGE_URL:
        description: url of the image just built.
    params:
      IMAGE:
        description: name (reference) of the image to build
      TAG:
        description: name (reference) of the image to build
      REGISTRY:
        description: registry FROM (base image)
        default: scr.tiab.labda.sva.de
      DOCKERFILE:
        description: Path to the Dockerfile to build
        default: ./Dockerfile
      CONTEXT:
        description: the build context used by Kaniko
        default: ./
      EXTRA_ARGS:
        type: array
      BUILDER_IMAGE:
        description: the image on which builds will run (default is v1.5.1)
        default: gcr.io/kaniko-project/executor:v1.5.1@sha256:c6166717f7fe0b7da44908c986137ecfeab21f31ec3992f6e128fff8a94be8a5
    steps:
      build-and-push:
        workingDir: $(workspaces.source.path)
        image: $(params.BUILDER_IMAGE)
        securityContext:
          runAsNonRoot: false
          runAsUser: 0
        args:
          - $(params.EXTRA_ARGS)
          - --dockerfile=$(params.DOCKERFILE)
          - --context=$(workspaces.source.path)/$(params.CONTEXT) # The user does not need to care the workspace and the source.
          - --destination=$(params.IMAGE):$(params.TAG)
          - --destination=$(params.IMAGE):latest
          - --build-arg=REGISTRY=$(params.REGISTRY)
          - --digest-file=$(results.IMAGE_DIGEST.path)
      write-url:
        image: docker.io/library/bash:5.1.4@sha256:b208215a4655538be652b2769d82e576bc4d0a2bb132144c060efc5be8c3f5d6
        script: |
          set -e
          image="$(params.IMAGE)"
          echo -n "${image}" | tee "$(results.IMAGE_URL.path)"
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
