


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
  approleId: MWQ0MmQ3ZTctOGMxNC1lNWY5LTgwMWQtYjNlY2VmNDE2NjE2
  approleSecret: NjIzYzk5MWYtZGQ3Ni1jNDM3LTI3MjMtYmIyZWY1YjAyZDg3
  caBundle: LS0tLS1CRUdJTis#...
EOF
```