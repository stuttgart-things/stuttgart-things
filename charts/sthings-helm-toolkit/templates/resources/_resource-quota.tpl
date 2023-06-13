{{- define "sthings-helm-toolkit.resource-quota" -}}
{{- $envVar := first . -}}
{{- $secretName := index . 1 -}}
{{- $secret := index . 2 -}}
apiVersion: v1
kind: ResourceQuota
metadata:
  name: resource-quota
  namespace: {{ .Values.namespace }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
spec:
  hard:
    requests.cpu: {{ .Values.quota.requests.cpu | default "1"}}
    requests.memory: {{ .Values.quota.requests.memory | default "1Gi"}}
    limits.cpu: {{ .Values.quota.limits.cpu | default "2"}}
    limits.memory: {{ .Values.quota.limits.memory | default "2Gi"}}
    pods: {{ .Values.quota.pods | default "10"}}
    persistentvolumeclaims: {{ .Values.quota.persistentvolumeclaims | default "20"}}
    resourcequotas: {{ .Values.quota.resourcequotas | default "1"}}
    services: {{ .Values.quota.services | default "5"}}
{{- end }}
