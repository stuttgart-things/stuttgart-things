# stuttgart-things/crossplane/cert-manager-config

## REGISTRY SECRET

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: cert-manager
  namespace: crossplane-system
type: Opaque
data:
  approleId: MWQ0MmQ..
  approleSecret: NjIzYzk5MWYt..
  caBundle: LS0tLS1CRUdJTis#...
EOF
```

## CLAIM
