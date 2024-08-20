---
secrets:
  - path: {{ vaultSecretPath }}/{{ clusterName }}:{{ vaultSecretKey }}
    target: {{ secretTargetPath }}/{{ clusterName }}
    b64: {{ secretFileBase64 }}
