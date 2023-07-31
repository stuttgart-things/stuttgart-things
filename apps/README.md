## FLUX/APPS

<details><summary>MINIO</summary>

```
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: s3-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  MINIO_ADMIN_USER: ""
  MINIO_ADMIN_PASSWORD: ""
```

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
    name: flux-system
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

<details><summary>REDIS</summary>

```
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: redis-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  REDIS_PASSWORD: ""
```

```
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: redis
  namespace: flux-system
  labels:
    alerting: flux2
spec:
  interval: 1h
  retryInterval: 1m
  timeout: 5m
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./apps/redis
  prune: true
  wait: true
  postBuild:
    substituteFrom:
      - kind: Secret
        name: redis-flux-secrets
```

</details>

<details><summary>KEDA</summary>

```
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: keda
  namespace: flux-system
spec:
  interval: 1h
  retryInterval: 1m
  timeout: 5m
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./apps/keda
  prune: true
  wait: true
```

</details>

<details><summary>HARBOR</summary>

```
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: harbor-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  HARBOR_ADMIN_USER: ""
  HARBOR_ADMIN_PASSWORD: ""
```

```
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: harbor
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
    name: flux-system
  path: ./apps/harbor
  prune: true
  wait: true
  postBuild:
    substitute:
      INGRESS_HOSTNAME: scr
      INGRESS_DOMAIN: app.4sthings.tiab.ssc.sva.de
      CLUSTER_ISSUER: cluster-issuer-approle
      STORAGE_CLASS: ontap
    substituteFrom:
      - kind: Secret
        name: harbor-flux-secrets
```

</details>
