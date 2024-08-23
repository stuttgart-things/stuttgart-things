---
template:
  zot: |
    ---
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .zotName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
      path: {{ .appsPath }}/{{ .zotName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          ZOT_NAMESPACE: {{ .zotNamespace }}
          ZOT_CHART_VERSION: {{ .zotVersion }}
          ZOT_PERSISTENCE: {{ .zotPersistence }}
          ZOT_STORAGE_SIZE: {{ .zotStorageSite }}
          INGRESS_HOSTNAME: {{ .zotIngressName }}
          INGRESS_SECRET_NAME: {{ .zotIngressSecret }}
          INGRESS_DOMAIN: {{ .clusterIngressDomain }}
          ZOT_STORAGE_CLASS: {{ .clusterStorageClass }}
          ISSUER_NAME: {{ .clusterCertIssuerName }}
          ISSUER_KIND: {{ .clusterCertIssuerKind }}
  ingress-nginx: |
    ---
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .ingressNginxName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
      path: {{ .infraPath }}/{{ .ingressNginxName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          INGRESS_NGINX_NAMESPACE: {{ .ingressNginxNamespace }}
          INGRESS_NGINX_CHART_VERSION: {{ .ingressNginxVersion }}
  metallb: |
    ---
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .metallbName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
      path: {{ .infraPath }}/{{ .metallbName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          METALLB_NAMESPACE: {{ .metallbNamespace }}
          IP_RANGE: {{ .metallbIPRange }}
          METALLB_CHART_VERSION: {{ .metallbVersion }}
  cert-manager: |
    ---
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
      postBuild:
        substitute:
          OPENEBS_NAMESPACE: {{ .openebsNamespace }}
          OPENEBS_CHART_VERSION: {{ .openebsVersion }}
          OPENEBS_VOLUMESNAPSHOT_CRDS: {{ .openebsInstallVolumeSnapshotCRDS }}
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