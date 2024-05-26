# stuttgart-things/ansbile/collections

## BASE-OS

### INSTALLATION

```bash
VERSION=0.2.3
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

<details><summary>GOLANG</summary>

installs golang on target system(s)

```bash
# DEPLOYMENT WITH DEFAULT OPTIONS (STHINGS USER EXPORTS)
ansible-playbook sthings.base_os.install_configure_golang -vv -i inventory

# DEPLOYMENT WITH OVERWRITES (DIFFRENT USER AND SPECIFY GOLANG VERSION)
ansible-playbook sthings.base_os.install_configure_golang \
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

### COLLECTION HISTORY

----------------
| DATE  | WHO | CHANGELOG |
|---|---|---|


## CONTAINER

### INSTALLATION

```bash
VERSION=0.2.3
ansible-galaxy collection install -f \
https://github.com/stuttgart-things/stuttgart-things/releases/download/${VERSION}/sthings-base_os-${VERSION}.tar.gz
```

### PLAYBOOKS

<details><summary>INSTALL-CONFIGURE-NERDCTL</summary>

</details>

<details><summary>INSTALL-CONFIGURE-DOCKER</summary>

###ADD DESCRIPTION

```bash
# DEPLOYMENT OF LATEST RUNTIME, CLI + COMPOSE
ansible-playbook sthings.base_os.install_configure_docker -vv -i inventory

# DEPLOYMENT OF LATEST RUNTIME, CLI, COMPOSE + KIND CLUSTER
ansible-playbook sthings.base_os.install_configure_docker \
-vv -i inventory install_kind=true
```

</details>


Author Information
------------------

```yaml
Andre Ebert, 04/2024, andre.ebert@sva.de, Stuttgart-Things
Xiaomin Lai, 03/2020, xiaomin.lai@sva.de, Stuttgart-Things
Patrick Hermann, 10/2019, patrick.hermann@sva.de, Stuttgart-Things
```
