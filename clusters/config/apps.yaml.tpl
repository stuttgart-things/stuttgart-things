---
template:
  flux-notifications: |
    ---
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .fluxAlertName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
      path: {{ .appsPath }}/{{ .fluxAlertName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          FLUX_NAMESPACE: {{ .fluxNamespace }}
          FLUX_GH_NOTIFICATION_PROVIDER: {{ .fluxGHNotificationProvider }}
          FLUX_REPO_URL: {{ .fluxRepoURL }}
          FLUX_GH_SECRET: {{ .fluxGHSecret }}
        substituteFrom:
          - kind: Secret
            name: {{ .fluxSecret }}

  gh-rss: |
    ---
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .ghRSSName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
      path: {{ .appsPath }}/{{ .ghRSSName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          GH_RSS_NAMESPACE: {{ .ghRSSNamespace }}
          GH_RSS_VERSION: {{ .ghRSSVersion }}
          GH_RSS_RUNNER_VERSION: {{ .ghRSSRunnerVersion }}
          GH_RSS_STORAGE_CLASS: {{ .ghRSSStorageClass }}
          GH_RSS_STORAGE_REQUEST: {{ .ghRSSStorageRequest }}
          GH_RSS_GITHUB_URL: {{ .ghRSSGitHubURL }}
          GH_RSS_REPOSIORY_NAME: {{ .ghRSSRepository }}
          GH_RSS_CLUSTER_NAME: {{ .clusterName }}
        substituteFrom:
          - kind: Secret
            name: {{ .ghRSSSecretName }}

  gh-arc: |
    ---
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .ghARCName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
      path: {{ .appsPath }}/{{ .ghARCName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          GH_ARC_NAMESPACE: {{ .ghARCNamespace }}
          GH_ARC_VERSION: {{ .ghARCVersion }}

  tekton: |
    ---
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .tektonName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
      path: {{ .appsPath }}/{{ .tektonName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          TEKTON_NAMESPACE: {{ .tektonNamespace }}
          TEKTON_PIPELINE_NAMESPACE: {{ .tektonPipelineNamespace }}
          TEKTON_VERSION: {{ .tektonVersion }}
          TEKTON_VAULT_SECRET: {{ .tektonVaultSecret }}
        substituteFrom:
          - kind: Secret
            name: {{ .tektonSecretName }}
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
          ZOT_PERSISTENCE: "{{ .zotPersistence }}"
          ZOT_STORAGE_SIZE: {{ .zotStorageSite }}
          INGRESS_HOSTNAME: {{ .zotIngressName }}
          INGRESS_SECRET_NAME: {{ .zotIngressSecret }}
          INGRESS_DOMAIN: {{ .clusterIngressDomain }}
          ZOT_STORAGE_CLASS: {{ .clusterStorageClass }}
          ISSUER_NAME: {{ .clusterCertIssuerName }}
          ISSUER_KIND: {{ .clusterCertIssuerKind }}
          ZOT_INGRESS_CLASS: {{ .clusterIngressClass }}
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
          OPENEBS_VOLUMESNAPSHOT_CRDS: "{{ .openebsInstallVolumeSnapshotCRDS }}"
          OPENEBS_ENABLE_MAYASTOR: "{{ .openebsEnableMayaStor }}"
          OPENEBS_ENABLE_LVM: "{{ .openebsEnableLVM }}"
          OPENEBS_ENABLE_ZFS: "{{ .openebsEnableZFS }}"

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