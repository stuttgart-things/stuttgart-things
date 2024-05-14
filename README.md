# stuttgart-things
[sˈθɪŋz] - using modularity to speed up parallel builds

used for configuration code like gitops configuration, ansible playbooks, Dockerfiles or helm charts.

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
```
Patrick Hermann, stuttgart-things 03/2023
Christian Mueller, stuttgart-things 08/2023
```
