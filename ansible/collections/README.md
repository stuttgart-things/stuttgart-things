# stuttgart-things/ansbile/collections

## BASE-OS

### INSTALLATION

```bash
VERSION=0.3.3
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
VERSION=0.0.20
ansible-galaxy collection install -f \
https://github.com/stuttgart-things/stuttgart-things/releases/download/${VERSION}/sthings-awx-${VERSION}.tar.gz
```

### PLAYBOOKS

<details><summary>BASE</summary>

base setup for awx: orga, projects + secrets

```bash
export CONTROLLER_HOST=https://awx.<DOMAIN>.sva.de #example!
export CONTROLLER_USERNAME=admin #example!
export CONTROLLER_PASSWORD=<PASSWORD>
ansible-playbook sthings.awx.base -vv
```

</details>


Author Information
------------------

```yaml
Andre Ebert, 04/2024, andre.ebert@sva.de, Stuttgart-Things
Xiaomin Lai, 03/2020, xiaomin.lai@sva.de, Stuttgart-Things
Patrick Hermann, 10/2019, patrick.hermann@sva.de, Stuttgart-Things
```
