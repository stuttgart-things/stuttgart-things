# stuttgart-things/machine-shop-operator/packer

## SET VAULT ENV VARS
```
export VAULT_NAMESPACE=root
export VAULT_ADDR=https://vault-vsphere.labul.sva.de:8200
export VAULT_TOKEN=<VAULT_TOKEN>
```

## APPLY
```
helmfile apply --environment labul-vsphere
```

## TEMPLATE
```
helmfile template --environment labda-vsphere
helmfile template --environment labda-vsphere | grep kind: -A 2 -B 2 # check for rendered kinds
```

Author Information
------------------
Patrick Hermann, stuttgart-things 06/2023