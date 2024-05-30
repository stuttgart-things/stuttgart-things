# WORKFLOWS

## DISPATCH ANSIBLE EXECUTION

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | [initial_master_node]+manager-proxmox-dev.labul.sva.de+[additional_master_nodes]    |
| PLAYBOOK NAME     | name/path of playbook     | sthings.deploy_rke.rke2                                                             |
| EXTRA VARS        | ansible vars (extra vars) | -e cluster_setup=singlenode -e rke2_k8s_version=v1.28.9 -e rke2_release_kind=rke2r1 |
| Private Key       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| Requirements File | path to requirements file | ansible/requirements.yaml                                                           |
|                   |                           |                                                                                     |

## DISPATCH PACKER TEMPLATE
