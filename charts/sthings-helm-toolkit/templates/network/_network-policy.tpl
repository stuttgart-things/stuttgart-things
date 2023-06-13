{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $networkPolicyName, $networkPolicyTpl := .Values.networkPolicys -}}
{{ include "sthings-helm-toolkit.network-policy" (list $envVar $networkPolicyName $networkPolicyTpl) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.network-policy" -}}
{{- $envVar := first . -}}
{{- $networkPolicyName := index . 1 -}}
{{- $networkPolicy := index . 2 -}}
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ $networkPolicyName }}
  namespace: {{ $networkPolicy.namespace | default $envVar.Values.namespace }}
  labels:
    {{- toYaml $networkPolicy.labels | nindent 4  }}
spec:
  policyTypes:
  {{- toYaml $networkPolicy.policyTypes | nindent 4  }}
  podSelector:
  {{- toYaml $networkPolicy.podSelector | nindent 4  }}
  ingress:
  {{- toYaml $networkPolicy.ingress | nindent 4  }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: basic-network-policy
    values: |
      networkPolicys:
        pdsg-database-network-policy:
          labels:
            app: pdsg-database
          policyTypes:
          - Ingress
          podSelector:
            matchLabels:
              app: pdsg-database
          ingress:
          - from:
            - podSelector:
                matchLabels:
                  app: pdsg
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
