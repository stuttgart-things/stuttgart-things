# stuttgart-things/packer

## SET VAULT ENV VARS
```
export VAULT_NAMESPACE=root

# labul-vsphere
export VAULT_ADDR=https://vault-vsphere.labul.sva.de:8200
export VAULT_TOKEN=<VAULT_TOKEN>

# labul-vsphere
export VAULT_ADDR=https://vault-vsphere.tiab.labda.sva.de:8200
export VAULT_TOKEN=<VAULT_TOKEN>
```

## APPLY
```
# export KUBECONFIG=~/.kube/dev11
helmfile sync --environment labul-vsphere # labda-vsphere
```

## TEMPLATE
```
helmfile template --environment labda-vsphere
helmfile template --environment labda-vsphere | grep kind: -A 2 -B 2 # check for rendered kinds
```

Author Information
------------------
Patrick Hermann, stuttgart-things 06/2023