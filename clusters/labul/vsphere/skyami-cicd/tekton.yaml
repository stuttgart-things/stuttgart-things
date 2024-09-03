---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: tekton
  namespace: flux-system
spec:
  interval: 1h
  retryInterval: 1m
  timeout: 5m
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./apps/tekton
  prune: true
  wait: true
  postBuild:
    substitute:
      TEKTON_NAMESPACE: tekton-pipelines
      TEKTON_PIPELINE_NAMESPACE: tektoncd
      TEKTON_VERSION: v0.60.4
      TEKTON_VAULT_SECRET: vault-in-cluster
    substituteFrom:
      - kind: Secret
        name: tekton-vault-secret
