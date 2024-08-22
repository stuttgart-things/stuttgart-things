---
template:
  cert-manager: |
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .certManagerName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
      path: {{ .infraPath }}/{{ .certManagerName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substituteFrom:
          - kind: Secret
            name: {{ .certManagerSecretName }}
      patches:
        - patch: |-
            - op: replace
              path: /spec/chart/spec/version
              value: {{ .certManagerVersion }}
          target:
            kind: HelmRelease
            name: {{ .certManagerName }}
            namespace: {{ .certManagerNamespace }}
  openebs: |
    ---
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .openebsName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
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
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .nfsCsiName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
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
    apiVersion: {{ .kustomizationApiVersion  }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .longhornName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
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