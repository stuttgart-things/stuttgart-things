{{/*
# includeStatement
{{- $envVar := . -}}
{{ include "sthings-helm-toolkit.deployment" (list $envVar) }}
*/}}

{{- define "sthings-helm-toolkit.deployment" -}}
{{- $envVar := first . -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ $envVar.Values.deployment.name | default (include "sthings-helm-toolkit.fullname" . )}}
  namespace: {{ $envVar.Values.deployment.namespace | default $envVar.Values.namespace }}
  labels:
    {{- toYaml $envVar.Values.deployment.labels | nindent 4 }}
  {{- if $envVar.Values.deployment.annotations }}
  annotations:
  {{- range $key, $value := $envVar.Values.deployment.annotations }}
    {{ $key }}: {{ $value | quote }}
  {{- end }}{{- end }}
spec:
  selector:
    matchLabels:
      {{- toYaml $envVar.Values.deployment.selectorLabels | nindent 6 }}
  replicas: {{ $envVar.Values.deployment.replicaCount }}
  revisionHistoryLimit: {{ $envVar.Values.deployment.revisionHistoryLimit | default "1" }}
  {{- if $envVar.Values.deployment.annotations }}
  annotations:
  {{- range $key, $value := $envVar.Values.deployment.annotations }}
    {{ $key }}: {{ $value | quote }}
  {{- end }}{{- end }}
  template:
    metadata:
      {{- with $envVar.Values.deployment.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        {{- toYaml $envVar.Values.deployment.labels | nindent 8 }}
    spec:
  {{- if $envVar.Values.deployment.affinity }}
      affinity:
        {{- toYaml $envVar.Values.deployment.affinity | nindent 8 }}
  {{- end }}
  {{- if $envVar.Values.deployment.terminationGracePeriodSeconds }}
      terminationGracePeriodSeconds: {{ $envVar.Values.deployment.terminationGracePeriodSeconds }}
  {{- end }}
  {{- if $envVar.Values.deployment.securityContext }}
      securityContext:
        runAsNonRoot: {{ $envVar.Values.deployment.securityContext.runAsNonRoot }}
  {{- end }}
  {{- if $envVar.Values.deployment.serviceAccount }}
      serviceAccountName: {{ $envVar.Values.deployment.serviceAccount }}
  {{- end }}
  {{- if $envVar.Values.deployment.imagePullSecrets }}
      imagePullSecrets:
    {{- range $envVar.Values.deployment.imagePullSecrets }}
        - name: {{ . }}
  {{- end}}{{- end}}
{{- if $envVar.Values.deployment.volumes }}
      volumes:
      {{- range $k, $v := $envVar.Values.deployment.volumes}}
        - name: {{ $k }}
        {{- if eq $v.volumeKind "emptyDir" }}
          emptyDir: {}{{- else if eq $v.volumeKind "configMap" }}
          configMap:
            name: {{ $k }}{{ else }}
          {{ $v.volumeKind }}:
            {{ $v.volumeKind }}Name: {{ $v.volumeRef }}{{ end }}{{ end }}{{ end }}
  {{- if $envVar.Values.deployment.initContainer }}
      initContainers:
      - name: {{ $envVar.Values.deployment.initContainer.name }}
        image: {{ $envVar.Values.deployment.initContainer.image }}:{{ $envVar.Values.deployment.initContainer.initTag | default "latest" }}
        imagePullPolicy: {{ $envVar.Values.deployment.initContainerimagePullPolicy | default "Always" }}
        securityContext:
          allowPrivilegeEscalation: {{ $envVar.Values.deployment.initContainer.allowPrivilegeEscalation | default "true" }}
          privileged: {{ $envVar.Values.deployment.initContainer.privileged | default "true" }}
          runAsNonRoot: {{ $envVar.Values.deployment.initContainer.runAsNonRoot | default "false" }}
          readOnlyRootFilesystem: {{ $envVar.Values.deployment.initContainer.readOnlyRootFilesystem | default "false" }}
          {{- if $envVar.Values.deployment.initContainer.runAsUser }}
          runAsUser: {{ $envVar.Values.deployment.initContainer.runAsUser | default "1000" }}{{- end }}
          {{- if $envVar.Values.deployment.initContainer.runAsGroup }}
          runAsGroup: {{ $envVar.Values.deployment.initContainer.runAsGroup | default "3000" }}{{- end }}
          {{- if $envVar.Values.deployment.initContainer.fsGroup }}
          fsGroup: {{ $envVar.Values.deployment.initContainer.fsGroup | default "2000" }}{{- end }}
        {{- if $envVar.Values.deployment.initContainer.resources }}
        resources:
          {{- if $envVar.Values.deployment.initContainer.resources.requests }}
          requests:
            cpu: {{ $envVar.Values.deployment.initContainer.resources.requests.cpu | default "100m" }}
            memory: {{ $envVar.Values.deployment.initContainer.resources.requests.memory | default "128Mi" }}
          {{- end }}
          {{- if $envVar.Values.deployment.initContainer.resources.limits }}
          limits:
            cpu: {{ $envVar.Values.deployment.initContainer.resources.limits.cpu | default "100m" }}
            memory: {{ $envVar.Values.deployment.initContainer.resources.limits.memory | default "128Mi" }}
          {{- end }}
        {{- end }}
        {{- if $envVar.Values.deployment.initContainer.command }}
        command:
        {{- range $envVar.Values.deployment.initContainer.command }}
          - {{ . }}
        {{- end }}{{- end }}
        {{- if $envVar.Values.deployment.initContainer.volumeMounts }}
        volumeMounts:
        {{- range $k, $v := $envVar.Values.deployment.initContainer.volumeMounts }}
          - name: {{ $k }}
            mountPath: {{ $v.mountPath }}
            {{- if $v.subPath }}
            subPath: {{ $v.subPath }}
            {{- end }}
        {{- end }}
        {{- end }}
  {{- end}}
      {{- if $envVar.Values.deployment.containers }}
      containers:
      {{- range $k, $v := $envVar.Values.deployment.containers }}
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
              name: {{ $k }}
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
      {{- end }}{{ else if $envVar.Values.deployment.image }}
      containers:
      - name: {{ $envVar.Values.deployment.name }}
        image: {{ $envVar.Values.deployment.image }}:{{ $envVar.Values.deployment.tag | default "latest" }}
        securityContext:
          allowPrivilegeEscalation: {{ $envVar.Values.deployment.allowPrivilegeEscalation | default "true" }}
          privileged: {{ $envVar.Values.deployment.privileged | default "true" }}
          runAsNonRoot: {{ $envVar.Values.deployment.runAsNonRoot | default "false" }}
          readOnlyRootFilesystem: {{ $envVar.Values.deployment.readOnlyRootFilesystem | default "false" }}
          {{- if $envVar.Values.deployment.runAsUser }}
          runAsUser: {{ $envVar.Values.deployment.runAsUser | default "1000" }}{{- end }}
          {{- if $envVar.Values.deployment.runAsGroup }}
          runAsGroup: {{ $envVar.Values.deployment.runAsGroup | default "3000" }}{{- end }}
          {{- if $envVar.Values.deployment.fsGroup }}
          fsGroup: {{ $envVar.Values.deployment.fsGroup | default "2000" }}{{- end }}
        imagePullPolicy: {{ $envVar.Values.deployment.imagePullPolicy | default "Always" }}
        ports:
        {{- range $k, $v := $envVar.Values.deployment.ports }}
          - name: {{ $k }}
            containerPort: {{ $v.containerPort }}
            protocol: {{ $v.protocol | default "TCP" }}
        {{- end }}
        {{- if or $envVar.Values.secrets $envVar.Values.configmaps }}
        envFrom:
        {{- end }}
        {{- if $envVar.Values.secrets }}
        {{- range $k, $v := $envVar.Values.secrets }}
        - secretRef:
            name: {{ $v.name }}
        {{- end }}{{- end }}
        {{- if $envVar.Values.configmaps }}
        {{- range $k, $v := $envVar.Values.configmaps }}
        - configMapRef:
            name: {{ $k }}
        {{- end }}{{- end }}
        {{- if $envVar.Values.deployment.probes}}
          {{- toYaml $envVar.Values.deployment.probes | nindent 8 }}
        {{- end }}
        {{- if $envVar.Values.deployment.commands }}
        command:
        {{- range $envVar.Values.deployment.commands }}
          - {{ . }}
        {{- end }}{{- end }}
        {{- if $envVar.Values.deployment.volumeMounts }}
        volumeMounts:
        {{- range $k, $v := $envVar.Values.deployment.volumeMounts }}
          - name: {{ $k }}
            mountPath: {{ $v.mountPath }}
            {{- if $v.subPath }}
            subPath: {{ $v.subPath }}
            {{- end }}
        {{- end }}
        {{- end }}
        resources:
          {{- if $envVar.Values.deployment.resources.requests }}
          requests:
            cpu: {{ $envVar.Values.deployment.resources.requests.cpu | default "100m" }}
            memory: {{ $envVar.Values.deployment.resources.requests.memory | default "128Mi" }}
          {{- end }}
          {{- if $envVar.Values.deployment.resources.limits }}
          limits:
            cpu: {{ $envVar.Values.deployment.resources.limits.cpu | default "100m" }}
            memory: {{ $envVar.Values.deployment.resources.limits.memory | default "128Mi" }}
          {{- end }}{{ end }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: deployment-one-container
    values: |
      deployment:
        name: sthings-slides
        namespace: sthings-slides
        labels:
          app: sthings-slides
        selectorLabels:
          app: sthings-slides
        image: scr.tiab.labda.sva.de/sthings-slides-template/sthings-slides-template
        tag: go-1.19
        replicaCount: 1
        imagePullPolicy: Always
        ports:
          app-port:
            containerPort: 8080
            protocol: TCP
        volumeMounts:
          workdir:
            mountPath: /work-dir
        allowPrivilegeEscalation: "false"
        privileged: "false"
        runAsNonRoot: "true"
        readOnlyRootFilesystem: "true"
        probes:
          livenessProbe:
            tcpSocket:
              path: /
              port: app-port
          readinessProbe:
            tcpSocket:
              path: /
              port: app-port
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 200m
            memory: 256Mi
        volumes:
          workdir:
            volumeKind: emptyDir
        initContainer:
          name: download-presentationfiles
          image: scr.labul.sva.de/sthings-tekton-runner/sthings-tekton-runner
          initTag: 2.0.0
          command:
            - "sh"
            - "-c"
            - "for file in sva-sthings-hackngrill.md workshop-kubernetes-seitenbau.md; do wget -nd -np -P /work-dir https://artifacts.tiab.labda.sva.de/presentationfiles/$file; done"
          volumeMounts:
            workdir:
              mountPath: /work-dir
  - name: multiple containers - complex structure
    values: |
      deployment:
        name: sthings-k8s-operator-controller-manager
        affinity:
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
              - matchExpressions:
                - key: kubernetes.io/arch
                  operator: In
                  values:
                  - amd64
                  - arm64
                  - ppc64le
                  - s390x
                - key: kubernetes.io/os
                  operator: In
                  values:
                  - linux
        containers:
          manager:
            image: scr.labul.sva.de/sthings-k8s-operator/sthings-k8s-operator
            tag: v22.0913.144
            imagePullPolicy: Always
            env:
              ANSIBLE_GATHERING:
                value: explicit
            securityContext:
              allowPrivilegeEscalation: false
              capabilities:
                drop:
                - ALL
            args:
              - --health-probe-bind-address=:6789
              - --metrics-bind-address=127.0.0.1:8080
              - --leader-elect
              - --leader-election-id=sthings-k8s-operator
            probes:
              livenessProbe:
                httpGet:
                  path: /healthz
                  port: 6789
                initialDelaySeconds: 15
                periodSeconds: 20
              readinessProbe:
                httpGet:
                  path: /readyz
                  port: 6789
                initialDelaySeconds: 5
                periodSeconds: 10
            resources:
              requests:
                cpu: 10m
                memory: 256Mi
              limits:
                cpu: 500m
                memory: 768Mi
          kube-rbac-proxy:
            image: gcr.io/kubebuilder/kube-rbac-proxy
            tag: v22.0913.144
            args:
              - --secure-listen-address=0.0.0.0:8443
              - --upstream=http://127.0.0.1:8080/
              - --logtostderr=true
              - --v=0
            imagePullPolicy: Always
            securityContext:
              capabilities:
                drop:
                  - ALL
              allowPrivilegeEscalation: false
              privileged: false
              runAsNonRoot: true
              readOnlyRootFilesystem: true
              # runAsGroup: 1000
              # runAsUser: 1000
              # fsGroup: 2000
            ports:
              https:
                containerPort: 8443
                protocol: TCP
            resources:
              requests:
                cpu: 5m
                memory: 64Mi
              limits:
                cpu: 500m
                memory: 128Mi
        labels:
          control-plane: controller-manager
        selectorLabels:
          control-plane: controller-manager
        replicaCount: 1
        terminationGracePeriodSeconds: 60
        serviceAccount: sthings-k8s-operator-controller-manager
        securityContext:
          runAsNonRoot: true
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}