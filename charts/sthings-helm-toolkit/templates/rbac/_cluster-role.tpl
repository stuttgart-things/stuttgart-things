{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $clusterRoleName, $clusterRole := .Values.clusterRoles -}}
{{ include "sthings-helm-toolkit.cluster-role" (list $envVar $clusterRoleName $clusterRole) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.cluster-role" -}}
{{- $envVar := first . -}}
{{- $clusterRoleName := index . 1 -}}
{{- $clusterRole := index . 2 -}}
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: {{ $clusterRoleName }}
  labels:
    {{- toYaml $clusterRole.labels | nindent 4  }}
rules:
  {{- toYaml $clusterRole.rules | nindent 2 }}
{{- end }}

{{/*
# exampleValues:
---
clusterRoles:
  sthings-k8s-operator-proxy-role:
    labels:
      app: sthings-k8s-operator
    rules:
      - apiGroups:
        - authentication.k8s.io
        resources:
        - tokenreviews
        verbs:
        - create
      - apiGroups:
        - authorization.k8s.io
        resources:
        - subjectaccessreviews
        verbs:
        - create
  sthings-k8s-operator-metrics-reader:
    labels:
      app: sthings-k8s-operator
    rules:
      - nonResourceURLs:
        - /metrics
        verbs:
        - get
  sthings-k8s-operator-manager-role:
    labels:
      app: sthings-k8s-operator
    rules:
      - apiGroups:
        - ""
        resources:
        - secrets
        - pods
        - pods/exec
        - pods/log
        - configmaps
        - persistentvolumeclaims
        - services
        - namespaces
        verbs:
        - create
        - delete
        - get
        - list
        - patch
        - update
        - watch
      - apiGroups:
        - apps
        resources:
        - deployments
        - daemonsets
        - replicasets
        - statefulsets
        verbs:
        - create
        - delete
        - get
        - list
        - patch
        - update
        - watch
      - apiGroups:
        - web.stuttgart-things.sthings.tiab.ssc.sva.de
        resources:
        - sthingsslides
        - sthingsslides/status
        - sthingsslides/finalizers
        verbs:
        - create
        - delete
        - get
        - list
        - patch
        - update
        - watch
      - apiGroups:
        - networking.k8s.io
        resources:
        - ingresses
        verbs:
        - create
        - delete
        - get
        - list
        - patch
        - update
        - watch
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
