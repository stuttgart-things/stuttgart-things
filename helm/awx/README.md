# AWX

## INIT
```bash
helmfile init # install helmfile plugins
```

##
```bash
helmfile template --file awx.ymal -e labul-vsphere #Example ENV
```

## APPLY
```bash
helmfile apply --file awx.yaml -e labul-vsphere #EXAMPLE ENV
```

## DESTROY
```bash
helmfile destroy --file awx.yaml -e labul-vsphere #EXAMPLE ENV
kubectl delete pvc postgres-15-awx-postgres-15-0 -n awx #EXAMPLE PVC DELETION
```