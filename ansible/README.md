# stuttgart-things/ansible

## SET VAULT ENV VARS
```
export VAULT_NAMESPACE=root

# LABDA
export VAULT_ADDR=https://vault-vsphere.tiab.labda.sva.de:8200
export VAULT_TOKEN=<VAULT_TOKEN>

# LABUL
export VAULT_ADDR=https://vault-vsphere.labul.sva.de:8200/
export VAULT_TOKEN=<VAULT_TOKEN>
```

## TEMPLATE
```
helmfile template --environment labda-vsphere
helmfile template --environment labda-vsphere | grep kind: -A 2 -B 2 # check for rendered kinds
```

## APPLY
```
helmfile sync --environment labda-vsphere
```

Author Information
------------------
Patrick Hermann, stuttgart-things 06/2023