# FLUX-CLUSTERS

## CREATE SECRETS FOR POST RENDER

<details><summary>SECRET MANIFESTS</summary>

```
apiVersion: v1
kind: Secret
metadata:
  name: vault
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
  name: msteams
  namespace: flux-system
type: Opaque
stringData:
  address: <MS-TEAMS-CHANNELURL>
```

</details>

## ADD CLUSTER / INSTALL FLUX ON CLUSTER

* Create/edit cluster config clusters/<LAB>/<CLOUD>/<CLUSTERNAME>

* hello

  <details><summary>SECRET MANIFESTS</summary>

```
apiVersion: v1
kind: Secret
metadata:
  name: vault
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
  name: msteams
  namespace: flux-system
type: Opaque
stringData:
  address: <MS-TEAMS-CHANNELURL>
```

    </details>


* Export Token + kubeconfig
```
export GITHUB_TOKEN=<TOKENDATA>
export KUBECONFIG=<PATH-TO-KUBECONFIGFILE>
```

* Bootstrap cluster
```
flux bootstrap github --owner=stuttgart-things --repository=stuttgart-things --path=clusters/<LAB>/<CLOUD>/<CLUSTERNAME>
```

## INSTALL FLUX-CLI

```
curl -s https://fluxcd.io/install.sh | sudo bash # linux
brew install fluxcd/tap/flux # macos
```

Author Information
------------------
Patrick Hermann, stuttgart-things 03/2023