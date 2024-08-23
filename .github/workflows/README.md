# WORKFLOWS

## DISPATCH ANSIBLE EXECUTION

<details><summary><b>RUN MORE THAN ONE PLAYBOOK (IN A LOOP)</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | manager-proxmox-dev.labul.sva.de |
| PLAYBOOK NAME     | name/path of playbook     | sthings.base_os.setup, sthings.container.tools                                                           |
| EXTRA VARS        | ansible vars (extra vars) |  |
| Private Key       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| Requirements File | path to requirements file | ansible/requirements.yaml                                                           |

</details>

<details><summary><b>BUILD SINGLE-NODE RKE2 CLUSTER</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | [initial_master_node]+manager-proxmox-dev.labul.sva.de+[additional_master_nodes]    |
| PLAYBOOK NAME     | name/path of playbook     | sthings.deploy_rke.rke2                                                             |
| EXTRA VARS        | ansible vars (extra vars) | -e cluster_setup=singlenode -e rke2_k8s_version=1.28.9 -e rke2_release_kind=rke2r1 |
| Private Key       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| Requirements File | path to requirements file | ansible/requirements.yaml                                                           |

</details>

<details><summary><b>BUILD MULTI-NODE RKE2 CLUSTER</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | [initial_master_node]+manager-proxmox-dev.labul.sva.de+[additional_master_nodes]+manager-proxmox-dev-2.labul.sva.de+manager-proxmox-dev-3.labul.sva.de+    |
| PLAYBOOK NAME     | name/path of playbook     | sthings.deploy_rke.rke2                                                             |
| EXTRA VARS        | ansible vars (extra vars) | -e cluster_setup=multinode |
| Private Key       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| Requirements File | path to requirements file | ansible/requirements.yaml                                                           |

</details>

<details><summary><b>UPLOAD KUBECONFIG TO VAULT</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | [initial_master_node]+sandiego2.labul.sva.de+ |
| PLAYBOOK NAME     | name/path of playbook     | ansible/playbooks/upload-kubeconfig-vault.yaml |
| EXTRA VARS        | ansible vars (extra vars) | -e kubeconfig_path=/etc/rancher/rke2/rke2.yaml -e secret_path_kubeconfig=kubeconfigs -e cluster_name=sandiego2 -e target_host=sandiego2 |
| Private Key       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| Requirements File | path to requirements file | ansible/requirements.yaml                                                           |

</details>

<details><summary><b>CREATE PDNS-ENTRY</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | localhost |
| PLAYBOOK NAME     | name/path of playbook     | ansible/playbooks/pdns-ingress-entry.yaml |
| EXTRA VARS        | ansible vars (extra vars) | -e hostname=sandiego2 -e ip_address=10.31.103.9 -e entry_zone=sthings-vsphere.labul.sva.de. -e pdns_url=https://pdns-vsphere.labul.sva.de:8443 |
| Private Key       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| Requirements File | path to requirements file | ansible/requirements.yaml                                                           |

</details>

## DISPATCH FLUX APPS

<details><summary><b>DEPLOY APP</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| CLUSTER-NAME      | name of target flux cluster | sandiego2 |
| APP-NAMES         | name of flux apps | zot |
| VALUES            | app/cluster specific values | clusterIngressDomain=sandiego2.sthings-vsphere.labul.sva.de |

</details>