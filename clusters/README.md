# FLUX-CLUSTERS

## CREATE SECRETS FOR POST RENDER

<details><summary>SECRET MANIFESTS</summary>

```
---
apiVersion: v1
kind: Namespace
metadata:
  name: flux-system
  labels:
    app: flux
---
apiVersion: v1
kind: Secret
metadata:
  name: vault-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  VAULT_ADDR: https://vault-vsphere.tiab.labda.sva.de:8200 #example
  VAULT_ROLE_ID: <ROLE_ID>
  VAULT_SECRET_ID: <SECRET_ID>
  VAULT_NAMESPACE: root #example
  VAULT_CA_BUNDLE: <CA_BUNDLE_BASE64>
  VAULT_PKI_PATH: 4sthings.tiab.ssc.sva.de #example
---
apiVersion: v1
kind: Secret
metadata:
  name: github-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  GIT_REPO_URL: https://github.com/stuttgart-things/stuttgart-things
  MS_TEAMS_URL: https://365sva.webhook.office.com/webhookb2/2f14a9f8-4736-46dd-9c8c-31547ec37180@0a65cb1e-37d5-41ff-980a-647d9d0e4f0b/IncomingWebhook/623bf0daab3d404baea9858fc689cf02/dc3a27ed-396c-40b7-a9b2-f1a2b6b44efe
  GITHUB_TOKEN: <GITHUB_TOKEN>
  PRIVATE_KEY: <PRIVATE_KEY_BASE64>
---
apiVersion: v1
kind: Secret
metadata:
  name: scr-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  SCR_HOSTNAME: scr.tiab.labda.sva.de
  SCR_USERNAME: <SCR_USERNAME>
  SCR_PASSWORD: <SCR_PASSWORD>
---
apiVersion: v1
kind: Secret
metadata:
  name: grafana-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  GRAFANA_PASSWORD: Atlan7is2024
---
apiVersion: v1
kind: Secret
metadata:
  name: s3-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  MINIO_ADMIN_USER: <MINIO_ADMIN_USER>
  MINIO_ADMIN_PASSWORD: <MINIO_ADMIN_PASSWORD>
---
apiVersion: v1
kind: Secret
metadata:
  name: harbor-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  HARBOR_ADMIN_USER: <HARBOR_ADMIN_USER>
  HARBOR_ADMIN_PASSWORD: <HARBOR_ADMIN_PASSWORD>
---
apiVersion: v1
kind: Secret
metadata:
  name: trident-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  TRIDENT_USER: <TRIDENT_USER>
  TRIDENT_PASSWORD: <TRIDENT_PASSWORD>
---
apiVersion: v1
kind: Secret
metadata:
  name: rancher-flux-secrets
  namespace: flux-system
type: Opaque
stringData:
  BOOTSTRAP_PASSWORD: <BOOTSTRAP_PASSWORD>
---
apiVersion: v1
kind: Secret
metadata:
  name: vault-mso-secrets
  namespace: flux-system
type: Opaque
stringData:
  VAULT_ADDR: https://vault.automation.sthings-vsphere.labul.sva.de
  VAULT_ROLE_ID: ef0222ff-7aa6-9954-32b6-1e6ab9206eae
  VAULT_SECRET_ID: bc4b844f-98a0-3063-2c6f-c83ce85678cc
  VAULT_NAMESPACE: root
```

</details>

## ADD CLUSTER / INSTALL FLUX ON CLUSTER

* Create/edit cluster config
  ```
  clusters/<LAB>/<CLOUD>/<CLUSTERNAME>
  ```
* Export Token + kubeconfig
  ```
  export GITHUB_TOKEN=<TOKENDATA>
  export KUBECONFIG=<PATH-TO-KUBECONFIGFILE>
  ```

* Bootstrap cluster
  ```
  flux bootstrap github --owner=stuttgart-things --repository=stuttgart-things \
  --path=clusters/<LAB>/<CLOUD>/<CLUSTERNAME>
  ```

* Check Flux status
  ```
  kubectl get Kustomization -A
  kubectl get hr -A
  ```

* If install retries are exhausted
  ```
  flux suspend hr <HR> -n <NAMESPACE>
  flux resume hr <HR> -n <NAMESPACE>
  ```

## INSTALL FLUX-CLI

```
curl -s https://fluxcd.io/install.sh | sudo bash # linux
brew install fluxcd/tap/flux # macos
```

Author Information
------------------
Patrick Hermann, stuttgart-things 03/2023
