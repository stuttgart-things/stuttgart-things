{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $roleName, $role := .Values.roles -}}
{{ include "sthings-helm-toolkit.role" (list $envVar $roleName $role) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.role" -}}
{{- $envVar := first . -}}
{{- $roleName := index . 1 -}}
{{- $role := index . 2 -}}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: {{ $roleName }}
  namespace: {{ $role.namespace | default $envVar.Values.namespace }}
  labels:
    {{- toYaml $role.labels | nindent 4  }}
rules:
  {{- toYaml $role.rules | nindent 2 }}
{{- end -}}

{{/*
# exampleValues:
---
roles:
  sthings-k8s-operator-leader-election-role:
    labels:
      app: sthings-k8s-operator
    rules:
      - apiGroups:
        - ""
        resources:
        - configmaps
        verbs:
        - get
        - list
        - watch
        - create
        - update
        - patch
        - delete
      - apiGroups:
        - coordination.k8s.io
        resources:
        - leases
        verbs:
        - get
        - list
        - watch
        - create
        - update
        - patch
        - delete
      - apiGroups:
        - ""
        resources:
        - events
        verbs:
        - create
        - patch
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
