---
template:
  nfs-sci: |
    apiVersion: {{ .apiVersion }}
    kind: {{ .kind }}
    metadata:
      name: {{ .nfsCsiName }}
      namespace: {{ .namespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: GitRepository
        name: flux-system
      path: {{ .infraPath }}/{{ .nfsCsiName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          NFS_SERVER_FQDN: {{ .nfsServer }}
          NFS_SHARE_PATH: {{ .nfsServerSharePath }}
          CLUSTER_NAME: {{ .clusterName }}
      patches:
        - patch: |-
            - op: replace
              path: /spec/chart/spec/version
              value: {{ .nfsCsiVersion }}
          target:
            kind: HelmRelease
            name: {{ .nfsCsiName }}
            namespace: {{ .nfsNamespace }}
  longhorn: |
    apiVersion: {{ .apiVersion }}
    kind: {{ .kind }}
    metadata:
      name: {{ .longhornName }}
      namespace: {{ .namespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .sourceKind }}
        name: {{ .sourceName }}
      path: {{ .infraPath }}/{{ .longhornName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          LONGHORN_NAMESPACE: {{ .longhornNamespace }}
      patches:
        - patch: |-
            - op: replace
              path: /spec/chart/spec/version
              value: {{ .longhornName }}
          target:
            kind: HelmRelease
            name: {{ .longhornName }}
            namespace: {{ .longhornVersion }}