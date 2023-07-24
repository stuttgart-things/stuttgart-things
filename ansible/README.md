# stuttgart-things/ansible

## OPERATIONS

<details><summary>ONLY VM CREATION</summary>

| FILE                                       | NEEDED/OPTIONAL CHANGES                                     |
|--------------------------------------------|-------------------------------------------------------------|
| helmfile.yaml                              | (only) release terraform must be enabled (set to installed) |
| environments/vm.yaml                       | set/change vmCount; vmName; vmNumCPUs; vmMemory; vmDiskSize |
| /environments/{{ .Environment.Name }}.yaml | set/change vmFolderPath; datastore; network                 |
|                                            |                                                             |

</details>

<details><summary>VM CREATION + BASEOS</summary>

| FILE                                       | NEEDED/OPTIONAL CHANGES                                     |
|--------------------------------------------|-------------------------------------------------------------|
| helmfile.yaml                              | all releases must be enabled (set to installed) |
| environments/vm.yaml                       | set/change vmCount; vmName; vmNumCPUs; vmMemory; vmDiskSize; set createInventory: true; copyInventory: false |
| environments/{{ .Environment.Name }}.yaml  | set/change vmFolderPath; datastore; network; ansibleTargets;                 |
|

</details>

<details><summary>NO VM CREATION + BASEOS (ON EXISTING VM)</summary>

| FILE                                       | NEEDED/OPTIONAL CHANGES                                     |
|--------------------------------------------|-------------------------------------------------------------|
| helmfile.yaml                              | secrets; ansible & job releases must be enabled |
| environments/vm.yaml                       | set createInventory: true; copyInventory: false |
| environments/{{ .Environment.Name }}.yaml  | set/change ansibleTargets; ansiblePlaybook: baseos-setup |
|

</details>

<details><summary>NO VM CREATION + CONFIGURE-RKE-NODE (ON EXISTING VM)</summary>

| FILE                                       | NEEDED/OPTIONAL CHANGES                                     |
|--------------------------------------------|-------------------------------------------------------------|
| helmfile.yaml                              | secrets; ansible & job releases must be enabled |
| environments/vm.yaml                       | set createInventory: true; copyInventory: false; ansiblePlaybook: configure-rke-node |
| environments/{{ .Environment.Name }}.yaml  | set/change ansibleTargets |
|

</details>



## EXECUTION

<details><summary>VAULT</summary>

```
export VAULT_NAMESPACE=root

# LABDA
export VAULT_ADDR=https://vault-vsphere.tiab.labda.sva.de:8200
export VAULT_TOKEN=<VAULT_TOKEN>

# LABUL
export VAULT_ADDR=https://vault-vsphere.labul.sva.de:8200
export VAULT_TOKEN=<VAULT_TOKEN> #...rTI1E
```

</details>

<details><summary>TEMPLATE/TEST</summary>

```
helmfile template --environment labda-vsphere
helmfile template --environment labda-vsphere | grep kind: -A 2 -B 2 # check for rendered kinds
```

</details>

<details><summary>SYNC/CREATE</summary>

```
export KUBECONFIG=~/.kube/...
helmfile sync --environment labda-vsphere
```

</details>

Author Information
------------------
Patrick Hermann, stuttgart-things 06/2023