# stuttgart-things/ansible

## TBD

* FlUX BOOTSTRAP
* FLUX SECRETS
* POWERDNS
* NFS-SERVER

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
| environments/vm.yaml                       | set/change vmCount; vmName; vmNumCPUs; vmMemory; vmDiskSize; ansibleTargets; set createInventory: true; ansiblePlaybook: baseos-setup; prepareEnv: true; executeBaseos: true |
| environments/{{ .Environment.Name }}.yaml  | set/change vmFolderPath; datastore; network; |
|

</details>

<details><summary>VM CREATION + (BASEOS) + NFS SERVER</summary>

| FILE                                       | NEEDED/OPTIONAL CHANGES                                     |
|--------------------------------------------|-------------------------------------------------------------|
| helmfile.yaml                              | all releases must be enabled (set to installed) |
| environments/vm.yaml                       | set/change vmCount; vmName; vmNumCPUs; vmMemory; vmDiskSize; ansibleTargets; createInventory: true; ansiblePlaybook: install-configure-nfs; prepareEnv: true; executeBaseos: true |
| environments/{{ .Environment.Name }}.yaml | set/change vmFolderPath; datastore; network; osTemplate; |
| defaults.yaml | set/change kind; permanent; nfsManageFirewall; nfsExportPaths |

</details>


<details><summary>VM CREATION + (BASEOS) + DEPLOY-UPGRADE-RKE</summary>

| FILE                                       | NEEDED/OPTIONAL CHANGES                                     |
|--------------------------------------------|-------------------------------------------------------------|
| helmfile.yaml                              | all releases must be enabled (set to installed) |
| environments/vm.yaml                       | set/change vmCount; vmName; vmNumCPUs; vmMemory; vmDiskSize; set inventory; createInventory: false; ansiblePlaybook: deploy-upgrade-rke; prepareEnv: true; executeBaseos: true |
| environments/{{ .Environment.Name }}.yaml  | set/change vmFolderPath; datastore; network; templatePath;                 |
| defaults.yaml  | set/change rkeVersion; k8sVersion; rke2ReleaseKind; enableIngressController; clusterSetup   |
|

</details>

<details><summary>NO VM CREATION + BASEOS/CONFIGURE-RKE-NODE (ON EXISTING VM)</summary>

| FILE                                       | NEEDED/OPTIONAL CHANGES                                     |
|--------------------------------------------|-------------------------------------------------------------|
| helmfile.yaml                              | secrets; ansible & job releases must be enabled |
| environments/vm.yaml                       | set createInventory: true; ansiblePlaybook: configure-rke-node; prepareEnv: true; ansibleTargets;  executeBaseos: true |

</details>

<details><summary>NO VM CREATION + DEPLOY-UPGRADE-RKE</summary>

| FILE                                       | NEEDED/OPTIONAL CHANGES                                     |
|--------------------------------------------|-------------------------------------------------------------|
| helmfile.yaml                              | secrets; ansible & job releases must be enabled |
| environments/vm.yaml                       | set inventory; createInventory: false; ansiblePlaybook: deploy-upgrade-rke |
| defaults.yaml  | set/change rkeVersion; k8sVersion; rke2ReleaseKind; enableIngressController; clusterSetup; prepareEnv: true; executeBaseos: true |
|

</details>

<details><summary>ADD INGRESS IP TO PNDS</summary>

| FILE                                       | NEEDED/OPTIONAL CHANGES                                     |
|--------------------------------------------|-------------------------------------------------------------|
| helmfile.yaml                              | secrets; ansible & job releases must be enabled |
| environments/vm.yaml                       | set createInventory: true; ansiblePlaybook: add-ingress-pdns.yaml |
| defaults.yaml  | set/change prepareEnv: false; executeBaseos: false; ipAddress; hostname |
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

<details><summary>CHECK</summary>

```
kubectl get terraform -A
kubectl get pods -n machine-shop
kubectl logs -f <container> -n machine-shop

# CHECK OPERATOR (TERRAFORM)
kubectl -n machine-shop-operator-system logs -f $(kubectl -n machine-shop-operator-system get po | grep operator | awk '{ print $1}') -c manager

# CHECK CREATED POD/JOB (ANSIBLE)
sleep 3 && kubectl -n machine-shop logs -f $(kubectl get po -n machine-shop | grep 'Running' | awk '{ print $1}') # sleep for inital start
kubectl -n machine-shop get job --sort-by=.metadata.creationTimestamp
```

</details>

Author Information
------------------
Patrick Hermann, stuttgart-things 06/2023