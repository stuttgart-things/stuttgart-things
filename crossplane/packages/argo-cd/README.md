# STUTTGART-THINGS/CROSSPLANE/ARGO-CD

## CLAIM

```bash
kubectl apply -f - <<EOF
---
apiVersion: resources.stuttgart-things.com/v1alpha1
kind: ArgoCd
metadata:
  name: homerun-dev
  namespace: crossplane-system
spec:
  deploymentNamespace: argo-cd
  version: 7.5.2
  clusterName: homerun-dev
  hostName: argo-cd
  domainName: homerun-dev.sthings-vsphere.labul.sva.de
  cert:
    secretName: argocd-server-tls
    issuerName: vault-approle
EOF
```

## INSTALL CONFIGURATION PACKAGE ON (XPLANE MGMT) CLUSTER

```bash
kubectl apply -f - <<EOF
apiVersion: pkg.crossplane.io/v1
kind: Configuration
metadata:
  name: argocd
spec:
  package: ghcr.io/stuttgart-things/stuttgart-things/xplane-argo-cd:7.5.2
EOF
```

## PROVIDER-CONFIG

### CREATE KUBECONFIG AS A SECRET FROM LOCAL FILE

```bash
CROSSPLANE_NAMESPACE=crossplane-system
CLUSTER_NAME=local
FOLDER_KUBECONFIG=~/.kube/
FILENAME_KUBECONFIG=rke2.yaml
```

```bash
kubectl -n ${CROSSPLANE_NAMESPACE} create secret generic ${CLUSTER_NAME} --from-file=${FOLDER_KUBECONFIG}/${FILENAME_KUBECONFIG}
```

### CREATE KUBERNETES PROVIDER CONFIG

```bash
kubectl apply -f - <<EOF
apiVersion: kubernetes.crossplane.io/v1alpha1
kind: ProviderConfig
metadata:
  name: ${CLUSTER_NAME}
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: ${CROSSPLANE_NAMESPACE}
      name: ${CLUSTER_NAME}
      key: ${FILENAME_KUBECONFIG}
EOF
```

### CREATE HELM PROVIDER CONFIG

```bash
kubectl apply -f - <<EOF
apiVersion: helm.crossplane.io/v1beta1
kind: ProviderConfig
metadata:
  name: ${CLUSTER_NAME}
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: ${CROSSPLANE_NAMESPACE}
      name: ${CLUSTER_NAME}
      key: ${FILENAME_KUBECONFIG}
EOF
```