# stuttgart-things/crossplane/ingress-nginx

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