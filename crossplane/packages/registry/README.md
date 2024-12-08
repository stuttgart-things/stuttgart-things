# stuttgart-things/crossplane/registry

## INSTALL CONFIGURATION PACKAGE ON (XPLANE MGMT) CLUSTER

```bash
kubectl apply -f - <<EOF
apiVersion: pkg.crossplane.io/v1
kind: Configuration
metadata:
  name: xplane-registry
spec:
  package: ghcr.io/stuttgart-things/stuttgart-things/xplane-registry:2.2.3
EOF
```

## REGISTRY SECRET

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: registry
  namespace: default
type: Opaque
stringData:
  HTPASSWD: |
    sthings:... # ADD HTPASSWD HERE
EOF
```

## CLAIM

```bash
kubectl apply -f - <<EOF
apiVersion: resources.stuttgart-things.com/v1alpha1
kind: Registry
metadata:
  name: fluxdev-2
  namespace: crossplane-system
spec:
  clusterName: kubernetes-incluster # This is the name of the Helm provider
  deploymentNamespace: registry
  domainName: fluxdev-2.sthings-vsphere.labul.sva.de
  storageClass: nfs4-csi
  storageSize: 2Gi
  version: 2.2.3
  cert:
    secretName: registry-ingress-tls
    issuerName: cluster-issuer-approle
EOF
```

## PROVIDER CONFIG

```bash
# ADDC SERVICE ACCOUNT CLUSTERROLEBINDING
SA=$(kubectl -n crossplane-system get sa -o name | grep provider-kubernetes | sed -e 's|serviceaccount\/|crossplane-system:|g')
kubectl create clusterrolebinding provider-kubernetes-admin-binding --clusterrole cluster-admin --serviceaccount="${SA}"
```
