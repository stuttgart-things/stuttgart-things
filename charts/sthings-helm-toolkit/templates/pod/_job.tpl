{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $jobName, $jobTpl := .Values.jobs -}}
{{ include "sthings-helm-toolkit.job" (list $envVar $jobName $jobTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.job" -}}
{{- $envVar := first . -}}
{{- $jobName := index . 1 -}}
{{- $job := index . 2 -}}
---
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ $job.name }}
  namespace: {{ $job.namespace | default $envVar.Values.namespace }}
{{- if $job.annotations }}
  annotations:
  {{- range $key, $value := $job.annotations }}
    {{ $key }}: {{ $value | quote }}
{{- end }}{{- end }}
{{- if $job.labels }}
  labels:
    {{- toYaml $job.labels | nindent 4  }}{{- end }}
spec:
  backoffLimit: {{ $job.backoffLimit | default 5 }}
  completionMode: {{ $job.completionMode | default "NonIndexed" }}
  completions: {{ $job.completions | default 1 }}
  parallelism: {{ $job.parallelism | default 1 }}
  template:
    metadata:
      name: {{ $job.name }}
      {{- if $job.labels }}
      labels:
        {{- toYaml $job.labels | nindent 8 }}{{- end }}
    spec:
      containers:
      {{- range $k, $v := $job.containers }}
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
      restartPolicy: {{ $job.restartPolicy | default "restartPolicy" }}
      {{- if $job.volumes }}
      volumes:
      {{- range $k, $v := $job.volumes }}
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
  - name: ansible-job
    values: |
      jobs:
        baseos-setup:
          name: baseos-setup
          namespace: ansible2
          labels:
            app: machine-shop-operator
            machine-shop-operator: ansible
          restartPolicy: Never
          volumes:
            ansible-playbooks:
              volumeKind: configMap
          containers:
            manager:
              image: eu.gcr.io/stuttgart-things/sthings-ansible
              tag: 7.5.0-5
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
                - "touch ${INV_PATH} && ansible-playbook -i $INV_PATH $HOME/ansible/play.yaml -vv -e target_play=baseos-setup"
              resources:
                requests:
                  cpu: 10m
                  memory: 256Mi
                limits:
                  cpu: 500m
                  memory: 768Mi
              volumeMounts:
                ansible-playbooks:
                  mountPath: /home/nonroot/ansible
              secretsEnvFrom:
                - name: vault
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2023
*/}}