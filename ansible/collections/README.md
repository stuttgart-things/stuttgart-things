# stuttgart-things/ansbile/collections

## BASE-OS

### INSTALLATION

```bash
VERSION=0.4.1
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

### COLLECTION HISTORY

----------------
| DATE  | WHO | CHANGELOG |
|---|---|---|


## CONTAINER

### INSTALLATION

```bash
VERSION=0.0.20
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
VERSION=0.0.48
ansible-galaxy collection install -f \
https://github.com/stuttgart-things/stuttgart-things/releases/download/${VERSION}/sthings-awx-${VERSION}.tar.gz
```

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


Author Information
------------------

```yaml
Andre Ebert, 04/2024, andre.ebert@sva.de, Stuttgart-Things
Xiaomin Lai, 03/2020, xiaomin.lai@sva.de, Stuttgart-Things
Patrick Hermann, 10/2019, patrick.hermann@sva.de, Stuttgart-Things
```
