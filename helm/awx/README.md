# AWX

## APPLY
```bash
helmfile apply --file awx.yaml -e labul-vsphere #EXAMPLE ENV
```

## DESTROY
```bash
helmfile destroy --file awx.yaml -e labul-vsphere #EXAMPLE ENV
kubectl delete pvc postgres-15-awx-postgres-15-0 -n awx #EXAMPLE PVC DELETION
```