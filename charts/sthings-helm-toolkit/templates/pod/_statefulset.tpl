{{/*
# includeStatement
{{- $envVar := . -}}
{{ include "sthings-helm-toolkit.statefulset" (list $envVar) }}
*/}}

{{- define "sthings-helm-toolkit.statefulset" -}}
{{- $envVar := first . -}}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ $envVar.Values.statefulset.name }}-statefulset
  namespace: {{ $envVar.Values.statefulset.namespace | default $envVar.Values.namespace }}
  labels:
    {{- toYaml $envVar.Values.statefulset.labels | nindent 4 }}
  {{- if $envVar.Values.statefulset.annotations }}
  annotations:
  {{- range $key, $value := $envVar.Values.statefulset.annotations }}
    {{ $key }}: {{ $value | quote }}
  {{- end }}{{- end }}
spec:
  replicas: {{ $envVar.Values.statefulset.replicas | default "1" }}
  revisionHistoryLimit: {{ $envVar.Values.statefulset.revisionHistoryLimit | default "1" }}
{{- if $envVar.Values.statefulset.updateStrategy }}
  updateStrategy:
{{ toYaml $envVar.Values.statefulset.updateStrategy | indent 4 }}
{{- end }}
  selector:
    matchLabels:
      {{- toYaml $envVar.Values.statefulset.selectorLabels | nindent 6 }}
  serviceName: {{ $envVar.Values.statefulset.name }}-service
  template:
    metadata:
      labels:
        {{- toYaml $envVar.Values.statefulset.labels | nindent 8 }}
    spec:
      terminationGracePeriodSeconds: {{ $envVar.Values.statefulset.terminationGracePeriodSeconds | default "10" }}
  {{- if $envVar.Values.statefulset.serviceAccount }}
      serviceAccountName: {{ $envVar.Values.statefulset.serviceAccount }}
  {{- end }}
  {{- if $envVar.Values.statefulset.imagePullSecrets }}
      imagePullSecrets:
    {{- range $envVar.Values.statefulset.imagePullSecrets }}
      - name: {{ . }}
  {{- end}}{{- end}}
      securityContext:
        allowPrivilegeEscalation: {{ $envVar.Values.statefulset.allowPrivilegeEscalation | default "true" }}
        privileged: {{ $envVar.Values.statefulset.privileged | default "true" }}
        runAsNonRoot: {{ $envVar.Values.statefulset.runAsNonRoot | default "false" }}
        readOnlyRootFilesystem: {{ $envVar.Values.statefulset.readOnlyRootFilesystem | default "false" }}
      {{- if $envVar.Values.statefulset.volumes }}
      volumes:
      {{- end }}
      {{- if $envVar.Values.statefulset.volumes }}
      {{- range $k, $v := $envVar.Values.statefulset.volumes }}
        - name: {{ $k }}
          {{ $v.type }}:
            name: {{ $v.name }}
      {{- end }}{{- end }}
      containers:
{{- if $envVar.Values.statefulset.containers }}
{{- range $k, $v := $envVar.Values.statefulset.containers }}
        - name: {{ $k }}
          image: {{ $v.image }}
          imagePullPolicy: {{ $v.imagePullPolicy }}
      {{- if $v.ports }}
          ports:
      {{- range $kp, $vp := $v.ports  }}
            - name: {{ $kp }}
              containerPort: {{ $vp.containerPort }}
              protocol: {{ $vp.protocol }}
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
        {{- if $v.probes }}
          {{- toYaml $v.probes | nindent 10 }}
        {{- end }}
        {{- if $v.env }}
          {{- toYaml $v.env | nindent 10 }}
        {{- end }}
        {{- if $v.command }}
          command:
        {{- range $v.command }}
            - {{ . }}
        {{- end }}{{- end }}
        {{- if $v.args }}
          args:
          {{- range $v.args }}
            - {{ . }}
          {{- end }}{{- end }}
        {{- if $v.volumeMounts }}
          volumeMounts:
        {{- range $km, $vm := $v.volumeMounts  }}
            - name: {{ $km }}
              mountPath: {{ $vm.mountPath }}
        {{- end }}{{- end }}
        {{- end }}
        {{- end }}{{- end }}
  volumeClaimTemplates:
  - metadata:
      name: {{ $envVar.Values.statefulset.name }}-data
    spec:
      accessModes:
      {{- if $envVar.Values.statefulset.volumeClaim.annotations }}
      annotations:
      {{- range $key, $value := $envVar.Values.statefulset.volumeClaim.annotations }}
        {{ $key }}: {{ $value | quote }}
      {{- end }}{{- end }}
      {{- range $envVar.Values.statefulset.volumeClaim.accessModes }}
        - {{ . | quote }}
      {{- end }}
      storageClassName: {{ $envVar.Values.statefulset.volumeClaim.storageClassName }}
      resources:
        requests:
          storage: {{ $envVar.Values.statefulset.volumeClaim.storageRequests | default "1Gi" }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: simple-statefulset
    values: |
      statefulset:
        name: demo-statefulset
        labels:
          app: demo-statefulset
        replicas: 1
        selectorLabels:
          app: demo-statefulset
        containers:
          demo-container:
            image: registry.access.redhat.com/ubi8/ubi:latest
            tag: v22.0913.144
            imagePullPolicy: Always
            ports:
              https:
                containerPort: 8443
                protocol: TCP
            volumeMounts:
              demo-volume-file-system:
                mountPath: "/data"
            resources:
              requests:
                cpu: 5m
                memory: 64Mi
              limits:
                cpu: 500m
                memory: 128Mi
        storageClassName: test
        volumes:
          demo-volume-file-system:
            type: persistentVolumeClaim
            name: demo-pvc-file-system
        volumeClaim:
          annotations:
          accessModes:
            - ReadWriteOnce
          storageClassName: thin-disk
          storageRequests: 1Gi
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
