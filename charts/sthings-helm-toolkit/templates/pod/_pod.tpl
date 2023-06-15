{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $podName, $podTpl := .Values.pods -}}
{{ include "sthings-helm-toolkit.pod" (list $envVar $podName $podTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.pod" -}}
{{- $envVar := first . -}}
{{- $podName := index . 1 -}}
{{- $pod := index . 2 -}}
---
apiVersion: v1
kind: Pod
metadata:
  name: {{ $pod.name }}
  namespace: {{ $pod.namespace | default $envVar.Values.namespace }}
{{- if $pod.annotations }}
  annotations:
  {{- range $key, $value := $pod.annotations }}
    {{ $key }}: {{ $value | quote }}
{{- end }}{{- end }}
{{- if $pod.labels }}
  labels:
    {{- toYaml $pod.labels | nindent 4  }}{{- end }}
spec:
  containers:
  {{- range $k, $v := $pod.containers }}
    - name: {{ $k }}
      image: {{ $v.image }}:{{ $v.tag }}
      imagePullPolicy: {{ $v.imagePullPolicy | default "Always" }}
      securityContext:
        {{- if $v.securityContext.capabilities }}
        capabilities:
          {{- toYaml $v.securityContext.capabilities | nindent 14 }}{{- end }}
        allowPrivilegeEscalation: {{ $v.securityContext.allowPrivilegeEscalation | default "true" }}
        privileged: {{ $v.securityContext.privileged | default "true" }}
        runAsNonRoot: {{ $v.securityContext.runAsNonRoot | default "false" }}
        readOnlyRootFilesystem: {{ $v.securityContext.readOnlyRootFilesystem | default "false" }}
        {{- if $v.securityContext.runAsUser }}
        runAsUser: {{ $v.securityContext.runAsUser | default "1000" }}{{- end }}
        {{- if $v.securityContext.runAsGroup }}
        runAsGroup: {{ $v.securityContext.runAsGroup | default "3000" }}{{- end }}
        {{- if $v.securityContext.fsGroup }}
        fsGroup: {{ $v.securityContext.fsGroup | default "2000" }}{{- end }}
      {{- if $v.ports }}
      ports:
      {{- range $key, $port := $v.ports }}
        - name: {{ $key }}
          containerPort: {{ $port.containerPort }}
          protocol: {{ $port.protocol | default "TCP" }}
      {{- end }}{{- end }}
      {{- if $v.env }}
      env:
      {{- range $key, $val := $v.env }}
        - name: {{ $key }}
          value: {{ $val | quote }}
      {{- end }}{{- end }}
      {{- if or $envVar.Values.secrets $envVar.Values.configmaps $v.secretsEnvFrom $v.configmapsEnvFrom }}
      envFrom:
      {{- end }}
      {{- if or $envVar.Values.secrets $v.secretsEnvFrom }}
      {{- if $envVar.Values.secrets }}
      {{- range $k, $v := $envVar.Values.secrets }}
      - secretRef:
          name: {{ $v.name }}
      {{- end }}{{- end }}
      {{- if $v.secretsEnvFrom }}
      {{- range $k, $v := $v.secretsEnvFrom }}
      - secretRef:
          name: {{ $v.name }}
      {{- end }}{{- end }}{{- end }}
      {{- if or $envVar.Values.configmaps $v.configmapsEnvFrom }}
      {{- if $envVar.Values.configmaps }}
      {{- range $k, $v := $envVar.Values.configmaps }}
      - configMapRef:
          name: {{ $k }}
      {{- end }}{{- end }}
      {{- if $v.configmapsEnvFrom }}
      {{- range $k, $v := $v.configmapsEnvFrom }}
      - configMapRef:
          name: {{ $v.name }}
      {{- end }}{{- end }}{{- end }}
      {{- if $v.probes }}
        {{- toYaml $v.probes | nindent 10 }}
      {{- end }}
      {{- if $v.args }}
      args:
      {{- range $v.args }}
        - {{ . }}
      {{- end }}{{- end }}
      {{- if $v.resources }}
      resources:
        {{- if $v.resources.requests }}
        requests:
          cpu: {{ $v.resources.requests.cpu | default "100m" }}
          memory: {{ $v.resources.requests.memory | default "128Mi" }}
        {{- end }}
        {{- if $v.resources.limits }}
        limits:
          cpu: {{ $v.resources.limits.cpu | default "100m" }}
          memory: {{ $v.resources.limits.memory | default "128Mi" }}
        {{- end }}
      {{- end }}
      {{- if $v.command }}
      command:
      {{- range $v.command }}
        - {{ . }}
      {{- end }}{{- end }}
      {{- if $v.volumeMounts }}
      volumeMounts:
      {{- range $key, $volume := $v.volumeMounts }}
        - name: {{ $key }}
          mountPath: {{ $volume.mountPath }}
          {{- if $volume.subPath }}
          subPath: {{ $volume.subPath }}
          {{- end }}
      {{- end }}{{- end }}
{{- end }}
{{- if $pod.volumes }}
  volumes:
  {{- range $k, $v := $pod.volumes }}
    - name: {{ $k }}
    {{- if eq $v.volumeKind "emptyDir" }}
      emptyDir: {}{{- else if eq $v.volumeKind "configMap" }}
      configMap:
        name: {{ $k }}{{ else }}
      {{ $v.volumeKind }}:
        {{ $v.volumeKind }}Name: {{ $v.volumeRef }}{{ end }}{{ end }}{{ end }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: deployment-one-container
    values: |
      pods:
        ansible-executor:
          name: ansible-executor
          namespace: ansible
          labels:
            app: machine-shop-operator
            machine-shop-operator: ansible
          volumes:
            workdir:
              volumeKind: emptyDir
          containers:
            manager:
              image: scr.labul.sva.de/sthings-k8s-operator/sthings-k8s-operator
              tag: v22.0913.144
              imagePullPolicy: Always
              env:
                ANSIBLE_HOST_KEY_CHECKING: "False"
                TARGETS: "10.100.136.72;10.100.136.73"
                INV_PATH: "/tmp/inv"
              securityContext:
                runAsUser: 65532
                allowPrivilegeEscalation: false
                privileged: true
                runAsNonRoot: true
                readOnlyRootFilesystem: false
              command:
                - "/bin/sh"
                - "-ec"
                - "touch ${INV_PATH} && sleep 1000"
              resources:
                requests:
                  cpu: 10m
                  memory: 256Mi
                limits:
                  cpu: 500m
                  memory: 768Mi
              volumeMounts:
                workdir:
                  mountPath: /work-dir
              secretsEnvFrom:
                - name: vault
              configmapsEnvFrom:
                - name: ansible-playbooks
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2023
*/}}