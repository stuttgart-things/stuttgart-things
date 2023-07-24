# stuttgart-things/ansible

## OPERATIONS
| USECASE          | INSTALLED (helmfile.yaml)                        | CHANGES                      | NEEDED VARIABLE CHANGES                    |
|------------------|--------------------------------------------------|------------------------------|--------------------------------------------|
| ONLY VM CREATION | terraform=true                                   | {{ .Environment.Name }}.yaml | * vmName: * ansibleTargets * vmFolderPath: |
| VM + BASEOS      | terraform=true secret=true ansible=true job=true |                              |                                            |                                                                  |



## SET VAULT ENV VARS
```
export VAULT_NAMESPACE=root

# LABDA
export VAULT_ADDR=https://vault-vsphere.tiab.labda.sva.de:8200
export VAULT_TOKEN=<VAULT_TOKEN>

# LABUL
export VAULT_ADDR=https://vault-vsphere.labul.sva.de:8200
export VAULT_TOKEN=<VAULT_TOKEN> #...rTI1E
```

## TEMPLATE / TEST
```
helmfile template --environment labda-vsphere
helmfile template --environment labda-vsphere | grep kind: -A 2 -B 2 # check for rendered kinds
```

## APPLY
```
export KUBECONFIG=~/.kube/...
helmfile sync --environment labda-vsphere
```

Author Information
------------------
Patrick Hermann, stuttgart-things 06/2023