{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $clusterRoleBindingName, $clusterRoleBinding := .Values.clusterRoleBindings -}}
{{ include "sthings-helm-toolkit.cluster-role-binding" (list $envVar $clusterRoleBindingName $clusterRoleBinding) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.cluster-role-binding" -}}
{{- $envVar := first . -}}
{{- $clusterRoleBindingName := index . 1 -}}
{{- $clusterRoleBinding := index . 2 -}}
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: {{ $clusterRoleBindingName }}
roleRef:
  kind: {{ $clusterRoleBinding.roleRef.kind }}
  name: {{ $clusterRoleBinding.roleRef.name }}
  apiGroup: {{ $clusterRoleBinding.roleRef.apiGroup }}
subjects:
{{- toYaml $clusterRoleBinding.subjects | nindent 2 }}
{{- end }}

{{/*
# exampleValues:
---
examples:
  - name: basic-cluster-role-binding
    values: |
      clusterRoleBindings:
        sthings-k8s-operator-manager-rolebinding:
          roleRef:
            kind: ClusterRole
            name: sthings-k8s-operator-manager-role
            apiGroup: rbac.authorization.k8s.io
          subjects:
            - kind: ServiceAccount
              name: sthings-k8s-operator-controller-manager
              namespace: sthings-k8s-operator-system
        sthings-k8s-operator-proxy-rolebinding:
          roleRef:
            kind: ClusterRole
            name: sthings-k8s-operator-proxy-role
            apiGroup: rbac.authorization.k8s.io
          subjects:
            - kind: ServiceAccount
              name: sthings-k8s-operator-controller-manager
              namespace: sthings-k8s-operator-system
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
