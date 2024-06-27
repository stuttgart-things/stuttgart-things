# stuttgart-things/ansible/collections

## BASE-OS

### INSTALLATION

```bash
VERSION=0.5.4
ansible-galaxy collection install -f \
https://github.com/stuttgart-things/stuttgart-things/releases/download/${VERSION}/sthings-base_os-${VERSION}.tar.gz
```

### PLAYBOOKS

<details><summary>SETUP</summary>

base setup for linux machine: updates, packages, ca, banner + filesystem.

```bash
ansible-playbook sthings.base_os.setup -vv -i /tmp/inv
```

</details>

<details><summary>TERRAFORM</summary>

deploys ansible + dependecies

```bash
# VSPHERE-TF-VARS PROFILE
ansible-playbook sthings.base_os.terraform \
-e tf_project_path=/home/andre/Projects/ansible/awx/base-codehub/terraform/vsphere-andre-vm \
-e tf_vars_profile=vsphere-terraform -vv
```
```bash
# PROXMOX-TF-VARS PROFILE
ansible-playbook sthings.base_os.terraform \
-e tf_project_path=/home/andre/Projects/ansible/awx/base-codehub/terraform/proxmox-andre-vm \
-e tf_vars_profile=proxmox-terraform -vv
```
```bash
# EXAMPLE GET TERRAFORM CONFIG FROM S3 BUCKET
ansible-playbook sthings.base_os.terraform \
-e tf_project_path=/home/andre/Projects/ansible/awx/base-codehub/terraform/vsphere-andre-vm \
-e tf_vars_profile=vsphere-terraform \
-e download_config_s3=true \
-e bucket_name=example-bucket \
-e object_name=example-object -vv
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

<details><summary>RENDER UPLOAD TEMPLATE/VM</summary>

## Render and upload rendered VM config to s3 bucket
```bash
# Default render of vm templates
ansible-playbook sthings.base_os.render_upload_vm -vv \
-e lab=labul \
-e cloud=vsphere
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
-e vm_cpu=2
```
</details>

### COLLECTION HISTORY

----------------
| DATE  | WHO | CHANGELOG |
|---|---|---|


## CONTAINER

### INSTALLATION

```bash
VERSION=0.0.22
ansible-galaxy collection install -f \
https://github.com/stuttgart-things/stuttgart-things/releases/download/${VERSION}/sthings-container-${VERSION}.tar.gz
```

### PLAYBOOKS

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
VERSION=0.0.57
ansible-galaxy collection install -f \
https://github.com/stuttgart-things/stuttgart-things/releases/download/${VERSION}/sthings-awx-${VERSION}.tar.gz
```


### VARIABLES

<details><summary>VARIABLES</summary>

* name:         Name of the job-template
* inventory:    Name of the inventory to use
* project:      Name of the Project the job-template should belong to
* state:        'present' to create job-template, 'absent' to delete job-template

</details>

### PLAYBOOKS

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
ansible-playbook sthings.awx.baseos -vv -e target_host=example.labul.sva.de
```

</details>

<details><summary>Hello-AWX</summary>

Awx job template to test Host w/ survey (without dynamic inventory)

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>
ansible-playbook sthings.awx.hello_awx -vv -e test_host=example.labul.sva.de
```

</details>

<details><summary>!! WORK IN PROGRESS !! RENDER UPLOAD TEMPLATE/VM</summary>

Awx job template /w survey and play to render and upload templates for VMs

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #EXAMPLE!
export CONTROLLER_USERNAME=admin #EXAMPLE!
export CONTROLLER_PASSWORD=<PASSWORD>

#create awx resource
ansible-playbook sthings.awx.render_upload_template -vv -e lab=labul -e cloud=vsphere -e j2_template_name=<example-template>.tf.j2 -e bucket_name=<example-bucket-name>

#use play to render and upload without awx
ansible-playbook sthings.awx.render_upload_vm -vv -e lab=labul -e cloud=vsphere -e j2_template_name=<example-template>.tf.j2 -e bucket_name=<example-bucket-name>
```

</details>

Author Information
------------------

```yaml
Andre Ebert, 04/2024, andre.ebert@sva.de, Stuttgart-Things
Xiaomin Lai, 03/2020, xiaomin.lai@sva.de, Stuttgart-Things
Patrick Hermann, 10/2019, patrick.hermann@sva.de, Stuttgart-Things
```
