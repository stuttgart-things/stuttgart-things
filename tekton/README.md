# stuttgart-things/tekton

## SET VAULT ENV VARS
```
export VAULT_NAMESPACE=root
export VAULT_TOKEN=<VAULT_TOKEN>
export VAULT_ADDR=https://vault-vsphere.tiab.labda.sva.de:8200
```

## TEMPLATE
```
helmfile template --environment labda-vsphere
helmfile template --environment labda-vsphere | grep kind: -A 2 -B 2 # check for rendered kinds
```

## APPLY
```
helmfile apply --environment labda-vsphere
```


Author Information
------------------
Patrick Hermann, stuttgart-things 06/2023
