---
template:
  nfsCsi: |
    apiVersion: kustomize.toolkit.fluxcd.io/v1
    kind: Kustomization
    metadata:
      name: nfs-csi
      namespace: {{ .namespace }}
    spec:
      interval: 1h
      retryInterval: 1m
      timeout: 5m
      sourceRef:
        kind: GitRepository
        name: flux-system
      path: ./infra/nfs-csi
      prune: true
      wait: true
      postBuild:
        substitute:
          NFS_SERVER_FQDN: 10.31.101.26
          NFS_SHARE_PATH: /data/col1/sthings
          CLUSTER_NAME: texas
      patches:
        - patch: |-
            - op: replace
              path: /spec/chart/spec/version
              value: v4.6.0
          target:
            kind: HelmRelease
            name: nfs-csi
            namespace: kube-system
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