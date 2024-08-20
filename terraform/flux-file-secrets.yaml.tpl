---
secrets:
  - path: {{ .vaultSecretPath }}/{{ .clusterName }}:{{ .vaultSecretKey }}
    target: {{ .kubeconfigTargetPath }}/{{ .clusterName }}
    b64: {{ .secretFileBase64 }}
