# WORKFLOWS

## DISPATCH ANSIBLE EXECUTION

<details><summary><b>BUILD SINGLE-NODE RKE2 CLUSTER</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | [initial_master_node]+manager-proxmox-dev.labul.sva.de+[additional_master_nodes]    |
| PLAYBOOK NAME     | name/path of playbook     | sthings.deploy_rke.rke2                                                             |
| EXTRA VARS        | ansible vars (extra vars) | -e cluster_setup=singlenode -e rke2_k8s_version=1.28.9 -e rke2_release_kind=rke2r1 |
| Private Key       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| Requirements File | path to requirements file | ansible/requirements.yaml                                                           |
|                   |                           |                                                                                     |

</details>

<details><summary><b>BUILD MULTI-NODE RKE2 CLUSTER</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | [initial_master_node]+rancher-mgmt.labul.sva.de+[additional_master_nodes]+rancher-mgmt-2.labul.sva.de+rancher-mgmt-3.labul.sva.de+
    |

</details>



## DISPATCH PACKER TEMPLATE
