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
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: vault-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  VAULT_ADDR: "" # https://vault...:8200
  VAULT_ROLE_ID: ""
  VAULT_SECRET_ID: ""
  VAULT_NAMESPACE: ""
  VAULT_PKI_PATH: ""
  VAULT_CA_BUNDLE: ""
  VAULT_TOKEN: ""
EOF
```

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

<details><summary>NFS-CSI</summary>

```
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: nfs-csi
  namespace: flux-system
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
      NFS_SERVER_FQDN: srvfiles-test.tiab.labda.sva.de
      NFS_SHARE_PATH: /var/nfs/k8s
```

</details>


<details><summary>FLUX-MONITORING</summary>

```
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: github-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  GIT_REPO_URL: ""
  MS_TEAMS_URL: ""
  GITHUB_TOKEN: ""
  PRIVATE_KEY: ""
```

```
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: flux-monitoring
  namespace: flux-system
spec:
  dependsOn:
    - name: cert-manager
  interval: 1h
  retryInterval: 1m
  timeout: 5m
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./infra/flux-monitoring
  prune: true
  wait: true
  postBuild:
    substitute:
      INGRESS_HOSTNAME: grafana
      INGRESS_DOMAIN: app.4sthings.tiab.ssc.sva.de
      CLUSTER_NAME: app
      CLUSTER_DESCRIPTION: app-labda-vsphere
    substituteFrom:
      - kind: Secret
        name: github-flux-secrets
```

</details>

<details><summary>RANCHER</summary>

```
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: rancher-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  BOOTSTRAP_PASSWORD: ref+vault://apps/rancher/password
EOF
```

```
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: rancher-things
  namespace: flux-system
  labels:
    alerting: flux2
spec:
  dependsOn:
    - name: ingress-nginx
    - name: cert-manager
  interval: 1h
  retryInterval: 1m
  timeout: 5m
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./apps/rancher
  prune: true
  wait: true
  postBuild:
    substitute:
      INGRESS_HOSTNAME: rancher-things
      INGRESS_DOMAIN: app.4sthings.tiab.ssc.sva.de
      CLUSTER_ISSUER: cluster-issuer-approle
    substituteFrom:
      - kind: Secret
        name: rancher-flux-secrets
```

</details>
