{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $configmapName, $configmapTpl := .Values.configmaps -}}
{{ include "sthings-helm-toolkit.configmap" (list $envVar $configmapName $configmapTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.configmap" -}}
{{- $envVar := first . -}}
{{- $configmapName := index . 1 -}}
{{- $configmapTpl := index . 2 -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configmapName }}
{{- if $envVar.Values.namespace }}
  namespace: {{ $envVar.Values.namespace }}
{{- end }}
data:
{{- if kindIs "map" $configmapTpl -}}
{{- tpl (toYaml $configmapTpl) $envVar | nindent 2 }}
{{ else }}
{{ tpl $configmapTpl $envVar | indent 2 }}
{{- end }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: basic-configmap-kvs
    values: |
      configmaps:
        yas-configuration:
          PIPELINE_WORKSPACE: yacht-tekton
  - name: basic-configmap-file
    values: |
      configmaps:
        sthings-k8s-operator-manager-config:
          controller_manager_config.yaml: |
            apiVersion: controller-runtime.sigs.k8s.io/v1alpha1
            kind: ControllerManagerConfig
            health:
              healthProbeBindAddress: :6789
            metrics:
              bindAddress: 127.0.0.1:8080
            leaderElection:
              leaderElect: true
              resourceName: 811c9dc5.stuttgart-things.sthings.tiab.ssc.sva.de
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
