{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $service, $serviceDefinition := .Values.services -}}
{{ include "sthings-helm-toolkit.service" (list $envVar $service $serviceDefinition) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.service" -}}
{{- $envVar := first . -}}
{{- $object := index . 1 -}}
{{- $objectDefinition := index . 2 -}}
{{- if contains "expose" (toJson $objectDefinition) -}}
---
apiVersion: v1
kind: Service
metadata:
  name: {{ $object }}{{ if not (contains "service" $object) }}-service{{ end }}
  namespace: {{ $envVar.Values.namespace | default $objectDefinition.namespace }}
  labels:
    {{- toYaml $objectDefinition.labels | nindent 4  }}
spec:
  {{- $type := dig "expose" "service" "type" "clusterIP" ($objectDefinition.ports | first ) }}
  {{- if (eq $type "Headless") }}
  type: ClusterIP
  clusterIP: None
  {{- else }}
  type: {{ $type }}
  {{- end }}
  ports:
    {{- range $portDefinition := $objectDefinition.ports }}
    {{- if contains "expose" (toJson $portDefinition) }}
    - targetPort: {{ $portDefinition.value }}
      name: {{ $portDefinition.name | default "http" }}
      port: {{ $portDefinition.expose.service.port | default $portDefinition.value }}
      protocol: {{ $portDefinition.expose.service.protocol | default "TCP" }}
    {{- end }}
    {{- end }}
    {{- end }}
  selector:
    {{- toYaml $objectDefinition.selectorLabels | nindent 4  }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: basic-service
    values: |
      ---
      services:
        sthings-backend-api:
          namespace: sthings-backend-api
          labels:
            app: sthings-backend-api
          ports:
            - name: app-port
              protocol: TCP
              value: 8000
              expose:
                service:
                  type: ClusterIP
                  port: 80
          selectorLabels:
            app: sthings-slides
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
