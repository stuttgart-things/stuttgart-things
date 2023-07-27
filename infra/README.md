# FLUX/INFRA

example Kustomizations

<details><summary>METALLB</summary>

```
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: metallb
  namespace: flux-system
spec:
  interval: 1h
  retryInterval: 1m
  timeout: 5m
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./infra/metallb
  prune: true
  wait: true
  postBuild:
    substitute:
      IP_RANGE: 10.31.103.11-10.31.103.12
```

</details>

<details><summary>INGRESS-NGINX</summary>

```
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: ingress-nginx
  namespace: flux-system
spec:
  interval: 1h
  retryInterval: 1m
  timeout: 5m
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./infra/ingress-nginx
  dependsOn:
    - name: metallb
  prune: true
  wait: true
```

</details>

<details><summary>LONGHORN</summary>

```
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: longhorn
  namespace: flux-system
spec:
  interval: 1h
  retryInterval: 1m
  timeout: 5m
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./infra/longhorn
  prune: true
  wait: true
```

</details>

<details><summary>CERT-MANAGER</summary>

```
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: cert-manager
  namespace: flux-system
spec:
  interval: 1h
  retryInterval: 1m
  timeout: 5m
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./infra/cert-manager
  prune: true
  wait: true
  postBuild:
    substituteFrom:
      - kind: Secret
        name: vault-flux-secrets
```

</details>
