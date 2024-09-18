# WORKFLOWS

## DISPATCH ANSIBLE EXECUTION

<details><summary><b>RUN MORE THAN ONE PLAYBOOK (IN A LOOP)</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | manager-proxmox-dev.labul.sva.de |
| PLAYBOOK NAME     | name/path of playbook     | sthings.base_os.setup, sthings.container.tools                                                           |
| EXTRA VARS        | ansible vars (extra vars) |  |
| PRIVATE KEY       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| REQUIREMENTS FILE | path to requirements file | ansible/requirements.yaml                                                           |

</details>

<details><summary><b>BUILD SINGLE-NODE RKE2 CLUSTER</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | [initial_master_node]+manager-proxmox-dev.labul.sva.de+[additional_master_nodes]    |
| PLAYBOOK NAME     | name/path of playbook     | sthings.deploy_rke.rke2                                                             |
| EXTRA VARS        | ansible vars (extra vars) | -e cluster_setup=singlenode -e rke2_k8s_version=1.28.9 -e rke2_release_kind=rke2r1 |
| PRIVATE KEY       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| REQUIREMENTS FILE | path to requirements file | ansible/requirements.yaml                                                           |

</details>

<details><summary><b>BUILD MULTI-NODE RKE2 CLUSTER</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | [initial_master_node]+manager-proxmox-dev.labul.sva.de+[additional_master_nodes]+manager-proxmox-dev-2.labul.sva.de+manager-proxmox-dev-3.labul.sva.de+    |
| PLAYBOOK NAME     | name/path of playbook     | sthings.deploy_rke.rke2                                                             |
| EXTRA VARS        | ansible vars (extra vars) | -e cluster_setup=multinode |
| PRIVATE KEY       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| REQUIREMENTS FILE | path to requirements file | ansible/requirements.yaml                                                           |

</details>

<details><summary><b>UPLOAD KUBECONFIG TO VAULT</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | [initial_master_node]+sandiego2.labul.sva.de+ |
| PLAYBOOK NAME     | name/path of playbook     | ansible/playbooks/upload-kubeconfig-vault.yaml |
| EXTRA VARS        | ansible vars (extra vars) | -e kubeconfig_path=/etc/rancher/rke2/rke2.yaml -e secret_path_kubeconfig=kubeconfigs -e cluster_name=sandiego2 -e target_host=sandiego2 |
| PRIVATE KEY       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| REQUIREMENTS FILE | path to requirements file | ansible/requirements.yaml                                                           |

</details>

<details><summary><b>CREATE PDNS-ENTRY</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | localhost |
| PLAYBOOK NAME     | name/path of playbook     | ansible/playbooks/pdns-ingress-entry.yaml |
| EXTRA VARS        | ansible vars (extra vars) | -e hostname=losangeles5 -e ip_address=10.31.103.19 -e entry_zone=sthings-vsphere.labul.sva.de. -e pdns_url=https://pdns-vsphere.labul.sva.de:8443 |
| PRIVATE KEY       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| REQUIREMENTS FILE | path to requirements file | ansible/requirements.yaml                                                           |

</details>

<details><summary><b>CREATE RKE CLUSTER + UPLOAD OF KUBECONFIG</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| INVENTORY         | inventory file as string  | [initial_master_node]+fluxdev-2.labul.sva.de+[additional_master_nodes]+fluxdev-2-2.labul.sva.de+fluxdev-2-3.labul.sva.de+ |
| PLAYBOOK NAME     | name/path of playbook     | sthings.deploy_rke.rke2,ansible/playbooks/upload-kubeconfig-vault.yaml |
| EXTRA VARS        | ansible vars (extra vars) | -e cluster_setup=multinode -e kubeconfig_path=/etc/rancher/rke2/rke2.yaml -e secret_path_kubeconfig=kubeconfigs -e cluster_name=fluxdev-2 -e target_host=fluxdev-2 -e rke2_k8s_version=1.28.9 -e rke2_release_kind=rke2r1 |
| PRIVATE KEY       | vault secret path         | ssh/data/sthings:privateKey                                                         |
| REQUIREMENTS FILE | path to requirements file | ansible/requirements.yaml                                                           |

#-e cluster_setup=multinode -e kubeconfig_path=/etc/rancher/rke2/rke2.yaml -e secret_path_kubeconfig=kubeconfigs -e cluster_name=fluxdev-2 -e target_host=fluxdev-2 -e rke2_k8s_version=1.31.0 -e rke2_release_kind=rke2r1

</details>


## DISPATCH FLUX APPS

<details><summary><b>DEPLOY BASE INFRA</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| CLUSTER-NAME      | name of target flux cluster | sandiego2 |
| APPS              | name of flux apps           | longhorn; nfs-csi; metallb; ingress-nginx; cert-manager |
| VALUES            | app/cluster specific values | metallbIPRange=10.31.103.19-10.31.103.20 |

</details>


<details><summary><b>DEPLOY APP</b></summary>

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| CLUSTER-NAME      | name of target flux cluster | sandiego2 |
| APP-NAMES         | name of flux apps | zot; openebs |
| VALUES            | app/cluster specific values | clusterIngressDomain=sandiego2.sthings-vsphere.labul.sva.de, clusterStorageClass=nfs4-csi |

# CICD CLUSTER

| NAME              | DESCRIPTION               | EXAMPLES                                                                            |
|-------------------|---------------------------|-------------------------------------------------------------------------------------|
| CLUSTER-NAME      | name of target flux cluster | sandiego2 |
| APP-NAMES         | name of flux apps | tekton; openebs; nfs-csi; gitlab-runner; flux-notifications; gh-arc; gh-arc; gh-rss |
| VALUES            | app/cluster specific values | fluxRepoURL=https://github.com/stuttgart-things/stuttgart-things, ghRSSRepository=kaeffken, ghRSSGitHubURL=https://github.com/stuttgart-things/kaeffken |


</details>
