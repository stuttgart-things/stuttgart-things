{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $applicationName, $applicationTpl := .Values.applications -}}
{{ include "sthings-helm-toolkit.argocd-application" (list $envVar $applicationName $applicationTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.argocd-application" -}}
{{- $envVar := first . -}}
{{- $applicationName := index . 1 -}}
{{- $application := index . 2 -}}
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: {{ $applicationName }}
  namespace: {{ $application.metadata.namespace | default "argo-cd" }}
  {{- if $application.metadata.annotations }}
  annotations:
  {{- range $key, $value := $application.metadata.annotations }}
    {{ $key }}: {{ $value | quote }}
  {{- end }}{{- end }}
  finalizers:{{- if $application.metadata.finalizers }}
  {{- range $application.metadata.finalizers }}
    - {{ . }}{{- end }}{{ else }}
    - resources-finalizer.argocd.argoproj.io{{ end }}
  labels:{{- if $application.metadata.labels }}
    {{- toYaml $application.metadata.labels | nindent 2 }}{{ else }}
    argocd.argoproj.io/instance: {{ $applicationName }}{{ end }}
spec:
  project: {{ $application.project | default "default" }}
  destination:
    name: ''
    namespace: {{ $application.destination.namespace }}
    server: {{ $application.destination.server }}
  source:
    repoURL: {{ $application.source.repoURL }}
    targetRevision: {{ $application.source.targetRevision }}
    {{- if $application.source.chart }}
    chart: {{ $application.source.chart }}
    {{- end }}
    {{- if $application.source.path }}
    path: {{ $application.source.path }}
    {{- end }}
    {{- if $application.source.kind }}
    {{- toYaml $application.source.kind | nindent 4 }}
    {{- end }}
{{- if $application.sync }}
  syncPolicy:
    automated:
      prune: {{ $application.sync.syncPolicy.automated.prune }}
      selfHeal: {{ $application.sync.syncPolicy.automated.selfHeal }}
    syncOptions:
    {{- range $application.sync.syncPolicy.syncOptions }}
      - {{ . }}{{- end }}
{{ else }}
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
{{- end }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: helm-nginx-long
    values: |
      applications:
        nginx:
          metadata:
            name: webserver
            namespace: argo-cd
            finalizers:
              - resources-finalizer.argocd.argoproj.io
            labels:
              argocd.argoproj.io/instance: nginx
          project: default
          destination:
            namespace: web
            server: https://kubernetes.default.svc
          source:
            kind:
              helm:
                releaseName: my-webserver
                parameters:
                  - name: service.type
                    value: NodePort
            chart: nginx
            repoURL: https://charts.bitnami.com/bitnami
            targetRevision: 13.2.12
          sync:
            syncPolicy:
              automated:
                prune: true
                selfHeal: true
              syncOptions:
                - CreateNamespace=true
  - name: helm-nginx-short
    values: |
      applications:
        nginx:
          metadata:
            namespace: argo-cd
          project: default
          destination:
            namespace: web
            server: https://kubernetes.default.svc
          source:
            kind:
              helm:
                releaseName: my-webserver
                parameters:
                  - name: service.type
                    value: NodePort
            chart: nginx
            repoURL: https://charts.bitnami.com/bitnami
            targetRevision: 13.2.12
  - name: git-manifests-path
    values: |
      applications:
        sthings-custom-resources:
          metadata:
            name: sthings-custom-resources
            namespace: argo-cd
            finalizers:
              - resources-finalizer.argocd.argoproj.io
            labels:
              argocd.argoproj.io/instance: sthings-custom-resources
          project: default
          destination:
            namespace: sthings-k8s-operator-system
            server: https://kubernetes.default.svc
          source:
            repoURL: git@codehub.sva.de:Lab/stuttgart-things/stuttgart-things.git
            targetRevision: HEAD
            path: gitops/custom-resources/
          sync:
            syncPolicy:
              automated:
                prune: true
                selfHeal: true
              syncOptions:
                - CreateNamespace=true
  - name: git-manifests-path
    values: |
      applications:
        sthings-cluster:
          metadata:
            name: sthings-cluster
            namespace: argo-cd
            finalizers:
              - resources-finalizer.argocd.argoproj.io
            labels:
              argocd.argoproj.io/instance: sthings-cluster
          project: default
          destination:
            namespace: sthings-cluster
            server: https://kubernetes.default.svc
          source:
            kind:
              plugin:
                name: argocd-vault-plugin-helm
                env:
                  - name: HELM_VALUES
                    value: |
                      namespaces:
                        sthings-k8s-operator:
                          name: sthings-k8s-operator-system
                          labels:
                            app: sthings-k8s-operator
            chart: sthings-cluster/sthings-cluster
            repoURL: scr.tiab.labda.sva.de
            targetRevision: 0.1.5-helm
          sync:
            syncPolicy:
              automated:
                prune: true
                selfHeal: true
              syncOptions:
                - CreateNamespace=true
*/}}


{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
