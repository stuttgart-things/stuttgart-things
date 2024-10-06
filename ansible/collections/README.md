# stuttgart-things/ansible/collections

## BASE-OS

### INSTALLATION

```bash
# RELEASE
VERSION=0.5.6
ansible-galaxy collection install -f \
https://github.com/stuttgart-things/stuttgart-things/releases/download/${VERSION}/sthings-base_os-${VERSION}.tar.gz

# DEV-EXAMPLE
VERSION=24.2741.18
ansible-galaxy collection install -f \
https://artifacts.homerun-dev.sthings-vsphere.labul.sva.de/ansible-collections/sthings-base_os-${VERSION}.tar.gz
```

### PLAYBOOKS

<details><summary>SETUP</summary>

base setup for linux machine: updates, packages, ca, banner + filesystem.

```bash
ansible-playbook sthings.base_os.setup -vv -i /tmp/inv
```

</details>

<details><summary>ANSIBLE</summary>

deploys ansible + dependecies

```bash
ansible-playbook sthings.base_os.ansible -vv -i /tmp/inv
```

</details>

<details><summary>GOLANG</summary>

installs golang on target system(s)

```bash
# DEPLOYMENT WITH DEFAULT OPTIONS (STHINGS USER EXPORTS)
ansible-playbook sthings.base_os.golang -vv -i inventory

# DEPLOYMENT WITH OVERWRITES (DIFFRENT USER AND SPECIFY GOLANG VERSION)
ansible-playbook sthings.base_os.golang \
-e golang_version=1.22.2 \
-e go_username=elon \
-e go_usergroup=dev \
-e go_userhome=/home/elon \
-vv -i inventory

# ADD TO PLAY AND README FOR USERS DICT
```

</details>

<details><summary>BINARIES</summary>

```bash
ansible-playbook sthings.base_os.binaries -vv -i /tmp/inv
```

</details>


<details><summary>USERS</summary>

```bash
ansible-playbook sthings.base_os.users -vv -i /tmp/inv
```

</details>

<details><summary>MANAGE PROXMOX</summary>

## Rename VM/Template
```bash
ansible-playbook sthings.base_os.rename_proxmox -vv -e vmname_old=myVM -e vmname_new=myNewVM -e target_host=localhost
```

## Delete VM/Template
```bash
ansible-playbook sthings.base_os.delete_proxmox -vv -e vmname_delete=example-name -e target_host=localhost
```

</details>

<details><summary>RENDER UPLOAD TEMPLATE/VM VSPHERE OR PROXMOX</summary>

## Render and upload rendered VM config to s3 bucket
```bash
# Default render of vm templates
ansible-playbook sthings.base_os.render_upload_vm -vv \
-e lab=labul \
-e cloud=vsphere \
-e s3=labul-automation
```

```bash
# Render w/ given name and size
ansible-playbook sthings.base_os.render_upload_vm -vv \
-e lab=labul \
-e cloud=vsphere \
-e vmSize=l \
-e vmName=martin \
-e s3=labul-automation
```

```bash
# Render with changed VM attributes
ansible-playbook sthings.base_os.render_upload_vm -vv \
-e lab=labul \
-e cloud=vsphere \
-e vmName=test-vm \
-e vmCount=1 \
-e vm_memory=4096 \
-e vm_template=ubuntu24 \
-e vm_disk=32 \
-e vm_cpu=2 \
-e s3=labul-automation
```
</details>

<details><summary>GET AND EXECUTE TERRAFORM ON VSPHERE OR PROXMOX</summary>

## Get rendered VM config and execute terraform
```bash
# Get vm config and execute terraform
ansible-playbook -i /path/to/inventory sthings.base_os.get_execute_terraform -vv \
-e lab=labul \
-e cloud=vsphere \
-e project_name=martin \
-e bucket_name=martin-vm-config \
-e object_name=2024-06-27-test-vnrqr.tf \
-e install_terraform=true \
-e s3=labul-automation
```

```bash
# Destroy VM
ansible-playbook -i /path/to/inventory sthings.base_os.get_execute_terraform -vv \
-e lab=labul \
-e cloud=vsphere \
-e project_name=martin \
-e bucket_name=martin-vm-config \
-e object_name=2024-06-27-test-vnrqr.tf \
-e s3=labul-automation \
-e state=absent
```
</details>

### COLLECTION HISTORY

----------------
| DATE  | WHO | CHANGELOG |
|---|---|---|


## CONTAINER

### INSTALLATION

```bash
# RELEASE
VERSION=0.0.22
ansible-galaxy collection install -f \
https://github.com/stuttgart-things/stuttgart-things/releases/download/${VERSION}/sthings-container-${VERSION}.tar.gz

# DEV-EXAMPLE
VERSION=24.33.47
ansible-galaxy collection install -f \
https://artifacts.homerun-dev.sthings-vsphere.labul.sva.de/ansible-collections/sthings-container-${VERSION}.tar.gz
```

### PLAYBOOKS

<details><summary>K3S</summary>

```bash
ansible-playbook sthings.container.k3s -vv -i /tmp/inv
```

</details>

<details><summary>DEPLOY HELM CHART (BY PROFILE)</summary>

```bash
ansible-playbook sthings.container.deploy_to_k8s \
-e path_to_kubeconfig=/etc/rancher/k3s/k3s.yaml \
-e profile=cert-manager \
-e state=present \
-i /tmp/inv \
-e target_host=all \
-vv
```

```bash
ansible-playbook sthings.container.deploy_to_k8s \
-e path_to_kubeconfig=/etc/rancher/k3s/k3s.yaml \
-e profile=argo-cd \
-e state=present \
-i /tmp/inv \
-e target_host=all \
-e ingress_host=michigan.labul.sva.de
-vv
```

</details>


<details><summary>DOCKER</summary>

###ADD DESCRIPTION

```bash
# DEPLOYMENT OF LATEST RUNTIME, CLI + COMPOSE
ansible-playbook sthings.container.docker -vv -i inventory

# DEPLOYMENT OF LATEST RUNTIME, CLI, COMPOSE + KIND CLUSTER
ansible-playbook sthings.container.docker \
-e install_kind=true \
-vv -i inventory
```

</details>

<details><summary>NERDCTL</summary>

```bash
ansible-playbook sthings.container.nerdctl -i /tmp/inv -vv
```

</details>

<details><summary>PODMAN</summary>

```bash
ansible-playbook sthings.container.podman -i /tmp/inv -vv
```

</details>

<details><summary>TOOLS</summary>

```bash
ansible-playbook sthings.container.tools -i /tmp/inv -vv
```

</details>

## AWX

### INSTALLATION

```bash
binary=sthings-awx-24.74.56.tar.gz
ansible-galaxy collection install -f \
https://artifacts.homerun-dev.sthings-vsphere.labul.sva.de/ansible-collections/${binary}
```

### VARIABLES

<details><summary>VARIABLES</summary>

* name:         Name of the job-template
* inventory:    Name of the inventory to use
* project:      Name of the Project the job-template should belong to
* state:        'present' to create job-template, 'absent' to delete
* cloud:        choose between vsphere and proxmox
* lab:          Choose between labul and labda

</details>

### PLAYBOOKS

<details><summary>DEPLOY JOBS SCRIPT</summary>

Replace/Add/Remove job names inside arr-Variable if you want to deploy specific jobs

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>

arr=("baseos" "golang" "nerdctl" "docker")
for i in ${!arr[@]};
do
  echo $i "${arr[i]}";
  ansible-playbook sthings.awx."${arr[i]}" -vv;
done
```


```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>

arr=("render_upload_template" "get_execute_terraform" "create_vm_workflow")
for i in ${!arr[@]};
do
  echo $i "${arr[i]}";
  ansible-playbook sthings.awx."${arr[i]}" -vv;
done
```

</details>

<details><summary>DOCKER</summary>

docker deployment awx job template w/ survey

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>
ansible-playbook sthings.awx.docker -vv
```

</details>

<details><summary>NERDCTL</summary>

nerdctl deployment awx job template w/ survey

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>
ansible-playbook sthings.awx.nerdctl -vv
```

</details>

<details><summary>GOLANG</summary>

golang deployment awx job template w/ survey

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>
ansible-playbook sthings.awx.golang -vv
```

</details>

<details><summary>BASE-OS</summary>

base-os deployment awx job template w/ survey

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>
ansible-playbook sthings.awx.baseos -vv
```

base-os deployment awx job template w/ survey AND scheduler
```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>
ansible-playbook sthings.awx.schedule_baseos -vv
```

</details>

<details><summary>Hello-AWX</summary>

Awx job template to test Host w/ survey (without dynamic inventory)

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>
ansible-playbook sthings.awx.hello_awx -vv
```

</details>

<details><summary>RENDER UPLOAD TEMPLATE</summary>

Awx job template /w survey and play to render and upload templates for VMs

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>

# Create awx resource to render and upload templates to s3
ansible-playbook sthings.awx.render_upload_template -vv \
-e lab=labul \
-e cloud=vsphere # example
```

</details>

<details><summary>PULL AND CREATE/DESTROY VM</summary>

Awx job template /w survey and play to pull templates from s3 and create/destroy VMs

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>

# Create awx resource to pull template from s3 and create/destroy VM
ansible-playbook sthings.awx.get_execute_terraform -vv \
-e lab=labul \
-e cloud=vsphere # example
```

</details>

<details><summary>CREATE VM WORKFLOW JOB TEMPLATE</summary>

Awx job template /w survey to create a workflow for vm creation in awx controller

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>

# Create awx resource to pull template from s3 and create/destroy VM
ansible-playbook sthings.awx.create_vm_workflow -vv \
```
</details>

## DEPLOY_RKE

### INSTALLATION

```bash
VERSION=1.28.10
ansible-galaxy collection install -f \
https://github.com/stuttgart-things/stuttgart-things/releases/download/${VERSION}/sthings-deploy_rke-${VERSION}.tar.gz
```

### PLAYBOOKS

<details><summary>INSTALL MULTI-NODE CLUSTER</summary>

Deploys a rke2 multi-node cluster.

```bash
# CREATE INVENTORY
cat <<EOF > rke2
[initial_master_node]
10.100.136.151
[additional_master_nodes]
10.100.136.152
10.100.136.153
EOF

# PLAYBOOK CALL
CLUSTER_NAME=rke2
mkdir -p ~/.kube/

ansible-playbook sthings.deploy_rke.rke2 \
-i rke2 \
-e rke2_fetched_kubeconfig_path=~/.kube/${CLUSTER_NAME} \
-e cluster_setup=multinode \
-e 1.28.10 \
-e rke2_release_kind=rke2r1
-vv
```

</details>

<details><summary>INSTALL SINGLE-NODE CLUSTER</summary>

Deploys a rke2 single-node cluster.

```bash
# CREATE INVENTORY
cat <<EOF > rke2
[initial_master_node]
10.100.136.151
[additional_master_nodes]
# no details needed but group needs to be defined
EOF

# PLAYBOOK CALL
CLUSTER_NAME=rke2

ansible-playbook sthings.deploy_rke.rke2 \
-i rke2 -vv \
-e rke2_fetched_kubeconfig_path=~/.kube/${CLUSTER_NAME} \
-e cluster_setup=singlenode \
-vv
```

</details>

<details><summary>DEPLOY METALLB</summary>

Deploys metallb helm chart + ip config

```bash
ansible-playbook sthings.deploy_rke.deploy_to_k8s \
-e deployment_vars=~/projects/rke2/metallb.yaml \
-e path_to_kubeconfig=~/.kube/rke2 \ # EXAMPLE
-e profile=metallb \
-e state=present \
-vv \
-e ip_range: 10.31.103.18-10.31.103.18 # example
```

</details>

<details><summary>DEPLOY INGRESS-NGINX</summary>

Deploys ingress-nginx helm chart

```bash
ansible-playbook sthings.deploy_rke.deploy_to_k8s \
-e path_to_kubeconfig=~/.kube/rke2 \
-e profile=ingress-nginx \
-e state=present \
-vv
```

</details>

<details><summary>DEPLOY CERT-MANAGER</summary>

Deploys cert-manager + config

```bash
# DEPLOYMENT VARS
cat <<EOF > cert-manager.yaml
cert_manager_version: v1.14.4
approle_id: 1d42d7e7-8c14-e5f9-801d-b3ecef416616
approle_secret: <SECRET>
name_cluster_issuer: cluster-issuer-approle
pki_path: pki/sign/sthings-vsphere.labul.sva.de
vault_server: https://vault-vsphere.labul.sva.de:8200
ca_bundle: LS0tLS0= #...
vault_secret: vault-approle

post_manifests:
  secret_approle: |
    apiVersion: v1
    kind: Secret
    metadata:
      name: {{ vault_secret }}
      namespace: {{ namespace }}
    data:
      approle: {{ approle_secret }}

  cluster_issuer: |
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: {{ name_cluster_issuer }}
      namespace: {{ namespace }}
    spec:
      vault:
        path: {{ pki_path }}
        server: {{ vault_server }}
        caBundle: {{ ca_bundle }}
        auth:
          appRole:
            path: approle
            roleId: {{ approle_id }}
            secretRef:
              name: {{ vault_secret }}
              key: approle
EOF

ansible-playbook sthings.deploy_rke.deploy_to_k8s \
-e path_to_kubeconfig=~/.kube/rke2 \
-e profile=cert-manager \
-e state=present \
-e deployment_vars=~/projects/rke2/cert-manager.yaml #ABSOLUTE PATH REQUIRED!
-vv
```

</details>

<details><summary>DEPLOY RANCHER</summary>

Deploys configuration + rancher

```bash
cat <<EOF > rancher.yaml
rancher_version: 2.8.5
hostname: rancher-things
domain: demo-rancher.sthings-vsphere.labul.sva.de  # EXAMPLE
password: "{{ lookup('community.general.random_string', length=17) }}"  # EXAMPLE
ca_certs: LS0tLS1CtLS0= #..
cluster_issuer: cluster-issuer-approle

pre_manifests:
  namespace: |
    apiVersion: v1
    kind: Namespace
    metadata:
      name: {{ deployment_namespace }}

  certificate: |
    apiVersion: cert-manager.io/v1
    kind: Certificate
    metadata:
      name: {{ hostname }}-ingress
      namespace: {{ deployment_namespace }}
    spec:
      commonName: {{ hostname }}.{{ domain }}
      dnsNames:
        - {{ hostname }}.{{ domain }}
      issuerRef:
        name: {{ cluster_issuer }}
        kind: ClusterIssuer
      secretName: {{ hostname }}-tls

  tls_secret: |
    apiVersion: v1
    kind: Secret
    metadata:
      name: tls-ca
      namespace: {{ deployment_namespace }}
    data:
      cacerts.pem: {{ ca_certs }}
post_manifests: {}
EOF

ansible-playbook sthings.deploy_rke.deploy_to_k8s \
-e path_to_kubeconfig=~/.kube/rke2 \
-e profile=cert-manager \
-e state=present \
-e deployment_vars=~/projects/rke2/cert-manager.yaml #ABSOLUTE PATH REQUIRED!
-vv
```

</details>

<details><summary>CREATE API-TOKEN</summary>

Creates rancher api token

```bash
ansible-playbook sthings.deploy_rke.api_token \
-e path_to_kubeconfig=~/.kube/rke2 \
-e token_name=admin \
-e token_description="admin api token" \
-e output_token_creds=true \
# -e token_password=whatever -> can be set
# -e token_user_id -> can be set / rancher user id (must exist)
-e state=present \
-vv
```

</details>

<details><summary>CREATE DOWNSTREAM-CLUSTER</summary>

Creates rancher downstream cluster (w/ api token + ssh)

```bash
# CREATE INVENTORY
cat <<EOF > ~/projects/rke2/dev1-inv
dev1-aio.tiab.labda.sva.de rancher_cluster_cmd="--controlplane --etcd --worker"

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF

# CREATE CLUSTER PROFILE
cat <<EOF > ~/projects/rke2/dev1.yaml
---
cluster_name: dev1
cluster_description: "{{ cluster_name }} cluster"
cni: cilium
kubernetes_version: v1.28.10+rke2r1
cluster_template: cluster
EOF

RANCHER_SECRET_KEY=<SECRET FROM TOKEN CREATION>

ansible-playbook sthings.deploy_rke.deploy_downstream_cluster \
-e path_to_kubeconfig=~/.kube/rke2 \
-e rancher_access_key=admin \
-e rancher_secret_key=${RANCHER_SECRET_KEY} \
-e rancher_hostname=rancher-things \
-e rancher_domain=demo-rancher.sthings-vsphere.labul.sva.de \
-e cluster_profile=~/projects/rke2/dev1.yaml \
-e state=present \
-e prepare_rke_nodes=true \
-i ~/projects/rke2/dev1-inv \
-vv
```

</details>

<details><summary>GET KUBECONFIG FROM DOWNSTREAM CLUSTER</summary>

Downloads kubeconfig from downstream cluster

```bash
ansible-playbook sthings.deploy_rke.get_downstream_kubeconfig \
-e rancher_access_key=admin \
-e rancher_secret_key=${RANCHER_SECRET_KEY} \
-e rancher_hostname=rancher-things \
-e rancher_domain=demo-rancher.sthings-vsphere.labul.sva.de \
-e cluster_name=dev1 \
-e kubeconfig_destination=/tmp/dev1 \
-e check_kubeconfig=true \
-vv
```

</details>


</details>


Author Information
------------------

```yaml
Andre Ebert, 04/2024, andre.ebert@sva.de, Stuttgart-Things
Xiaomin Lai, 03/2020, xiaomin.lai@sva.de, Stuttgart-Things
Patrick Hermann, 10/2019, patrick.hermann@sva.de, Stuttgart-Things
```
