# stuttgart-things/ansible

## OPERATIONS

### ONLY VM CREATION

* ./helmfile.yaml: (only) release terraform must be enabled (set to installed)
* ./environments/vm.yaml: set/change vmCount; vmName; vmNumCPUs; vmMemory; vmDiskSize
* ./environments/{{ .Environment.Name }}.yaml: set/change vmFolderPath; datastore; network

### VM CREATION + BASEOS

* ./helmfile.yaml: all releases must be enabled (set to installed)
* ./environments/vm.yaml: set/change vmCount; vmName; vmNumCPUs; vmMemory; vmDiskSize
* ./environments/{{ .Environment.Name }}.yaml: set/change vmFolderPath; datastore; network; ansibleTargets; createInventory: true; copyInventory: false

### NO VM CREATION + BASEOS

* ./helmfile.yaml: secrets; ansible & job releases must be enabled
* ./environments/{{ .Environment.Name }}.yaml: set/change ansibleTargets; createInventory: true; copyInventory: false

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