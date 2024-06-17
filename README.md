# stuttgart-things
[sˈθɪŋz] - using modularity to speed up parallel builds

used for configuration code like gitops configuration, ansible playbooks, Dockerfiles or helm charts.

<img alt="Ansible" src="https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white"/><img alt="Docker" src="https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white"/><img alt="Kubernetes" src="https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white"/>

[![Button Component](https://readme-components.vercel.app/api?component=button&text=Stuttgart-Things-Blog)](https://stuttgart-things.github.io/stuttgart-things/)


<img src="https://github.com/stuttgart-things/docs/blob/main/hugo/sthings-boat.png" alt="GeeksforGeeks logo" align="right" width="200">

## INFRASTRUCTURE AS CODE

### ANSIBLE

<details><summary>sthings-base_os</summary>

#### INSTALL

[CHECK RELEASES](https://github.com/stuttgart-things/stuttgart-things/releases)

```bash
# INSTALL ROLE - EXAMPLE VERSION
COLLECTION_VERSION=0.1.8
ansible-galaxy collection install -f \
https://github.com/stuttgart-things/stuttgart-things/releases/download/${COLLECTION_VERSION}/sthings-base_os-${COLLECTION_VERSION}.tar.gz
```


#### DEPLOY BINARIES (DEV-MACHINE PROFILE)

```bash
ansible-playbook sthings.base_os.download_install_binaries \
-i inv -vv \
-e target_host=all \
-e profile=dev \
-vv
```

</details>

Author Information
------------------

```bash
Patrick Hermann, stuttgart-things 03/2023
Christian Mueller, stuttgart-things 08/2023
```
