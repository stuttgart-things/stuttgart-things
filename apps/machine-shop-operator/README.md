# stuttgart-things/machine-shop-operator

## ISSUES

* none

## APPLY TO ENV
```
export VAULT_NAMESPACE=root
export VAULT_TOKEN=<VAULT_TOKEN>
export VAULT_ADDR=https://vault-vsphere.tiab.labda.sva.de:8200

helmfile diff --environment labda
helmfile apply --environment labda
```


Author Information
------------------
Patrick Hermann, stuttgart-things 06/2023
