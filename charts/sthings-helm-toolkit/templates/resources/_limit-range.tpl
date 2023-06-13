{{- define "sthings-helm-toolkit.limit-range" -}}
{{- $envVar := first . -}}
{{- $secretName := index . 1 -}}
{{- $secret := index . 2 -}}
apiVersion: v1
kind: LimitRange
metadata:
  name: limit-range
  namespace: {{ .Values.namespace }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
spec:
  limits:
  - default:
      cpu: {{ .Values.limits.default.cpu | default "200m" }}
      memory: {{ .Values.limits.default.memory | default "512Mi" }}
    defaultRequest:
      cpu: {{ .Values.limits.defaultRequest.cpu | default "100m"}}
      memory: {{ .Values.limits.defaultRequest.memory | default "256Mi"}}
    type: {{ .Values.limits.type | default "Container" }}
{{- end }}
