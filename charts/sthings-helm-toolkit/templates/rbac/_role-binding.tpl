{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $roleBindingName, $roleBinding := .Values.roleBindings -}}
{{ include "sthings-helm-toolkit.role-binding" (list $envVar $roleBindingName $roleBinding) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.role-binding" -}}
{{- $envVar := first . -}}
{{- $roleBindingName := index . 1 -}}
{{- $roleBinding := index . 2 -}}
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: {{ $roleBindingName }}
  namespace: {{ $roleBinding.namespace | default $envVar.Values.namespace }}
roleRef:
  kind: {{ $roleBinding.roleRef.kind }}
  name: {{ $roleBinding.roleRef.name }}
  apiGroup: {{ $roleBinding.roleRef.apiGroup }}
subjects:
{{- toYaml $roleBinding.subjects | nindent 2 }}
{{- end }}


{{/*
# exampleValues:
---
roleBindings:
  sthings-k8s-operator-leader-election-rolebinding:
    roleRef:
      kind: Role
      name: sthings-k8s-operator-leader-election-role
      apiGroup: rbac.authorization.k8s.io
    subjects:
      - kind: ServiceAccount
        name: sthings-k8s-operator-controller-manager
        namespace: sthings-k8s-operator-system
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
