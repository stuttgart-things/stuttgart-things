{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $ingress, $ingressDefinition := .Values.ingress -}}
{{ include "sthings-helm-toolkit.ingress" (list $envVar $ingress $ingressDefinition) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.ingress" -}}
{{- $envVar := first . -}}
{{- $ingressName := index . 1 -}}
{{- $ingress := index . 2 -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ $ingress.name }}
  namespace: {{ $envVar.Values.namespace | default $ingress.namespace }}
  {{- if $ingress.annotations }}
  annotations:
  {{- range $key, $value := $ingress.annotations }}
    {{ $key }}: {{ $value | quote }}
  {{- end }}{{- end }}
  labels:
    {{- toYaml $ingress.labels | nindent 4  }}
spec:
  {{- if $ingress.ingressClassName }}
  ingressClassName: {{ $ingress.ingressClassName }}
  {{- end }}
  rules:
  {{- if $ingress.clusterName }}
    - host: {{ $ingress.hostname }}.{{ $ingress.clusterName }}.{{ $ingress.domain }}{{ else }}
    - host: {{ $ingress.hostname }}.{{ $ingress.domain }}
  {{- end }}
      http:
        paths:
          - backend:
              service:
                name: {{ $ingress.service.name }}
                port:
                  number: {{ $ingress.service.port }}
            path: {{ $ingress.service.path }}
            pathType: {{ $ingress.service.pathType | default "ImplementationSpecific" }}
  {{- if $ingress.tls }}
  tls:
  - secretName: {{ $ingress.tls.secretName }}
    hosts:
      - {{ $ingress.tls.host }}
  {{- end }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: basic-ingress
    values: |
      ingress:
        sthings-slides:
          name: sthings-slides
          namespace: sthings-slides
          ingressClassName: nginx
          annotations:
            nginx.ingress.kubernetes.io/ssl-redirect: "false"
          service:
            name: sthings-slides-service
            port: 8000
            path: /
            pathType: ImplementationSpecific
          hostname: sthings-slides
          clusterName: silence2
          domain: sthings.tiab.ssc.sva.de
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
