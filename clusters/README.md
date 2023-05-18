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
  name: github
  namespace: flux-system
type: Opaque
stringData:
  MS_TEAMS_URL: https://365sva.webhook.office.com/webhookb2/2f14a9f8-4736-46dd-9c8c-31547ec37180@0a65cb1e-37d5-41ff-980a-647d9d0e4f0b/IncomingWebhook/623bf0daab3d404baea9858fc689cf02/dc3a27ed-396c-40b7-a9b2-f1a2b6b44efe
  GITHUB_TOKEN: <GITHUB_TOKEN>
  PRIVATE_KEY: <PRIVATE_KEY_BASE64>
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

## INSTALL FLUX-CLI

```
curl -s https://fluxcd.io/install.sh | sudo bash # linux
brew install fluxcd/tap/flux # macos
```

Author Information
------------------
Patrick Hermann, stuttgart-things 03/2023
