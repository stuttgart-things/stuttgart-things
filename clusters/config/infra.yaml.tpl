---
template:
  openebs: |
    ---
    apiVersion: {{ .apiVersion }}
    kind: {{ .kind }}
    metadata:
      name: {{ .openebsName }}
      namespace: {{ .namespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: GitRepository
        name: {{ .namespace }}
      path: {{ .infraPath }}/{{ .openebsName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      patches:
        - patch: |-
            - op: replace
              path: /spec/chart/spec/version
              value: {{ .openebsVersion }}
          target:
            kind: HelmRelease
            name: {{ .openebsName }}
            namespace: {{ .openebsNamespace }}
  nfs-csi: |
    ---
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
        name: {{ .namespace }}
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
        - patch: |-
            - op: replace
              path: /spec/values/externalSnapshotter/customResourceDefinitions/enabled
              value: false
          target:
            kind: HelmRelease
            name: nfs-csi
            namespace: flux-system
  longhorn: |
    ---
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
              value: {{ .longhornVersion }}
          target:
            kind: HelmRelease
            name: {{ .longhornName }}
            namespace: {{ .longhornNamespace }}