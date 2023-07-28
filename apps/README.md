## FLUX/APPS

<details><summary>MINIO</summary>

```
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: minio
  namespace: flux-system
  labels:
    alerting: flux2
spec:
  dependsOn:
    - name: ingress-nginx
    - name: cert-manager
    - name: trident
  interval: 1h
  retryInterval: 1m
  timeout: 5m
  sourceRef:
    kind: GitRepository
    name: infra-june-2023
  path: ./apps/minio
  prune: true
  wait: true
  postBuild:
    substitute:
      INGRESS_HOSTNAME_API: artifacts
      INGRESS_HOSTNAME_CONSOLE: artifacts-console
      INGRESS_DOMAIN: app.4sthings.tiab.ssc.sva.de
      CLUSTER_ISSUER: cluster-issuer-approle
    substituteFrom:
      - kind: Secret
        name: s3-flux-secrets
```

</details>