---
template:
  crossplane: |
    ---
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .crossplaneName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
      path: {{ .appsPath }}/{{ .crossplaneName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          CROSSPLANE_NAMESPACE: {{ .crossplaneNamespace }}
          CROSSPLANE_VERSION: {{ .crossplaneVersion }}
          CROSSPLANE_HELM_PROVIDER_VERSION: "{{ .crossplaneHelmProviderVersion }}"
          CROSSPLANE_K8S_PROVIDER_VERSION: "{{ .crossplaneK8sProviderVersion }}"
          CROSSPLANE_TERRAFORM_PROVIDER_VERSION: "{{ .crossplaneTerraformProviderVersion }}"
          CROSSPLANE_TERRAFORM_PROVIDER_IMAGE: "{{ .crossplaneTerraformProviderImage }}"
          CROSSPLANE_TERRAFORM_S3_SECRET_NAME: "{{ .crossplaneTerraformS3SecretName }}"
        substituteFrom:
          - kind: Secret
            name: {{ .crossplaneTerraformS3SecretName }}

  vault: |
    ---
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .vaultName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
      path: {{ .infraPath }}/{{ .vaultName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          VAULT_NAMESPACE: {{ .vaultNamespace }}
          VAULT_VERSION: {{ .vaultVersion }}
          VAULT_INJECTOR_ENABLED: "{{ .vaultInjectorEnabled }}"
          VAULT_SERVER_ENABLED: "{{ .vaultServerEnabled }}"
          VAULT_STORAGE_ENABLED: "{{ .vaultStorageEnabled }}"
          VAULT_INGRESS_ENABLED: "{{ .vaultIngressEnabled }}"
          VAULT_STORAGE_CLASS: "{{ .vaultStorageClass }}"
          VAULT_INGRESS_HOSTNAME: {{ .vaultHostname }}
          VAULT_INGRESS_DOMAIN: {{ .clusterIngressDomain }}
          VAULT_CSI_ENABLED: "{{ .vaultCsiEnabled }}"
          ISSUER_NAME: {{ .clusterCertIssuerName }}
          ISSUER_KIND: {{ .clusterCertIssuerKind }}

  gitlab-runner: |
    ---
    apiVersion: {{ .kustomizationApiVersion }}
    kind: {{ .kustomizationKind  }}
    metadata:
      name: {{ .gitlabRunnerName }}
      namespace: {{ .fluxNamespace }}
    spec:
      interval: {{ .interval }}
      retryInterval: {{ .retryInterval }}
      timeout: {{ .timeout }}
      sourceRef:
        kind: {{ .fluxSourceKind }}
        name: {{ .fluxGitRepository }}
      path: {{ .appsPath }}/{{ .gitlabRunnerName }}
      prune: {{ .prune }}
      wait: {{ .wait }}
      postBuild:
        substitute:
          GITLAB_CLUSTER_NAME: {{ .clusterName }}
          GITLAB_RUNNER_NAMESPACE: {{ .gitlabRunnerNamespace }}
          GITLAB_CHART_VERSION: {{ .gitlabRunnerChartVersion }}
          GITLAB_CONCURRENT_JOBS: "{{ .gitlabRunnerConcurrentJobs }}"
          GITLAB_CHECK_INTERVAL: "{{ .gitlabRunnerCheckInterval }}"
          GITLAB_RUNNER_URL: {{ .gitlabRunnerUrl }}
        substituteFrom:
          - kind: Secret
            name: {{ .gitlabRunnerSecretName }}

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
      path: {{ .infraPath }}/{{ .fluxAlertName }}
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
          METALLB_IP_RANGE: {{ .metallbIPRange }}
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
        substitute:
          CERT_MANAGER_VERSION: {{ .certManagerVersion }}
          CERT_MANAGER_NAMESPACE: {{ .certManagerNamespace }}
          CERT_MANAGER_INSTALL_CRDS: "{{ .certManagerInstallCRDs }}"
        substituteFrom:
          - kind: Secret
            name: {{ .certManagerSecretName }}

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
          NFS_CSI_NAMESPACE: {{ .nfsCsiNamespace }}
          NFS_CSI_VERSION: {{ .nfsCsiVersion }}
          NFS_CSI_ENABLE_CRDS: "{{ .nfsCsiEnableCRDs }}"
          NFS_CSI_ENABLE_SNAPSHOTTER: "{{ .nfsCsiEnableSnapshotter }}"

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
          LONGHORN_VERSION: {{ .longhornVersion }}
          LONGHORN_DEFAULT_STORAGECLASS: "{{ .longhornDefaultStorageClass }}"
          LONGHORN_DEFAULT_FSTYPE: {{ .longhornDefaultFsType }}
          LONGHORN_RECLAIM_POLICY: {{ .longhornReclaimPolicy }}
