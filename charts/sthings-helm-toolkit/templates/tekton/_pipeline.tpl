{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $pipelineName, $pipelineTpl := .Values.pipelines -}}
{{ include "sthings-helm-toolkit.pipeline" (list $envVar $pipelineName $pipelineTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.pipeline" -}}
{{- $envVar := first . -}}
{{- $pipelineName := index . 1 -}}
{{- $pipeline := index . 2 -}}
---
apiVersion: tekton.dev/{{ $pipeline.apiVersion | default "v1" }}
kind: Pipeline
metadata:
  name: {{ $pipelineName }}
  namespace: {{ $pipeline.namespace | default $envVar.Values.defaultNamespace }}
{{- if $pipeline.annotations }}
  annotations:
  {{- range $key, $value := $pipeline.annotations }}
    {{ $key }}: {{ $value | quote }}
{{- end }}{{- end }}
spec:
  {{- if $pipeline.workspaces }}
  workspaces:
    {{- range $pipeline.workspaces }}
    - name: {{ . }}{{- end }}
    {{- end }}
  {{- if $pipeline.params }}
  params:
    {{- range $k, $v := $pipeline.params }}
    - name: {{ $k }}
      type: {{ $v.type | default "string" }}
      {{- if $v.default }}
      default: {{ $v.default | quote }}{{ else }}
      {{- if eq $v.type "array" }}
      default: []
      {{ else }}
      default: ""{{- end }}{{- end }}
      description: {{ $v.description }}{{- end }}
    {{- end }}
  tasks:
  {{- range $k, $t := $pipeline.tasks }}
    - name: {{ $k }}
      {{- if $t.runAfter }}
      runAfter:
      {{- range $t.runAfter }}
        - {{ . }}{{- end }}
      {{- end }}
      taskRef:
        kind: Task
        name: {{ $t.task }}
      {{- if $t.workspaces }}
      workspaces:
        {{- range $k, $v := $t.workspaces }}
        - name: {{ $k }}
          workspace: {{ $v.workspace }}
        {{- end }}
      {{- end }}
      {{- if $t.params }}
      params:
      {{- range $ke, $ve := $t.params }}
        - name: {{ $ke }}
        {{- if $ve.values }}
          value:
          {{- range $ve.values }}
            - {{ . }}{{- end }}
          {{- else }}
        {{- if $ve.value }}
          value: {{ $ve.value }}{{ else }}
          value: ""{{- end }}{{- end }}
        {{- end }}{{- end }}
      {{- if $t.when }}
      when:
      {{- range $ke, $ve := $t.when }}
        - input: {{ $ke }}
          operator: {{ $ve.operator }}
          values: ["{{ $ve.values }}"]{{- end }}
      {{- end }}
  {{- end }}
  {{- if $pipeline.finally }}
  finally:
  {{- range $k, $f := $pipeline.finally }}
    - name: {{ $k }}
      taskRef:
        kind: Task
        name: {{ $f.task }}
    {{- if $f.params }}
      params:
      {{- range $ke, $ve := $f.params }}
        - name: {{ $ke }}
          value: {{ $ve.value }}{{- end }}
  {{- end }}
    {{- if $f.when }}
      when:
      {{- range $ke, $ve := $f.when }}
        - input: {{ $ke }}
          operator: {{ $ve.operator }}
          values: ["{{ $ve.values }}"]{{- end }}
  {{- end }}
  {{- end }}
  {{- end }}
{{- end }}

{{/*
# exampleValues:
---
pipelines:
  build-kaniko-image:
    namespace: sthings-tekton
    workspaces:
      - shared-workspace
      - ssh-credentials
      - dockerconfig
    params:
      image:
        description: reference of the image to build
      tag:
        description: reference of the tag of the image to build
      registry:
        description: registry FROM (base image)
      gitRepoUrl:
        description: source git repo
      context:
        description: path to context
      dockerfile:
        description: path to dockerfile
    tasks:
      fetch-repository:
        task: git-clone
        workspaces:
          output:
            workspace: shared-workspace
          ssh-directory:
            workspace: ssh-credentials
        params:
          url:
            value: $(params.gitRepoUrl)
          subdirectory:
            value: ""
          deleteExisting:
            value: "'true'"
      kaniko:
        task: kaniko
        runAfter:
          - fetch-repository
        workspaces:
          source:
            workspace: shared-workspace
          dockerconfig:
            workspace: dockerconfig
        params:
          IMAGE:
            value: $(params.image)
          TAG:
            value: $(params.tag)
          REGISTRY:
            value: $(params.registry)
          CONTEXT:
            value: $(params.context)
          DOCKERFILE:
            value: $(params.dockerfile)
          EXTRA_ARGS:
            values:
              - --skip-tls-verify
      send-webhook-msteams:
        task: send-msteams-webhook
        runAfter:
          - kaniko
        params:
          message:
            value: "image $(params.image):$(params.tag) build & pushed successfully w/ kaniko ($(tasks.kaniko.results.IMAGE_DIGEST))"
          webhook-url-secret:
            value: msteams
          webhook-url-secret-key:
            value: url
    finally:
      notify-any-failure:
        task: send-msteams-webhook
        params:
          message:
            value: "kaniko image build for $(params.image):$(params.tag) failed!!"
        when:
          $(tasks.status):
            operator: in
            values: Failed
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
