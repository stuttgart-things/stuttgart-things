# stuttgart-things/packer

## OVERVIEW

| OS       | PROVISIOING | CLOUD   | LAB   | TEMPLATE-NAME   | BUILD-DATE |
|----------|-------------|---------|-------|-----------------|------------|
| UBUNTU24 | BASE-OS     | VSPHERE | LABUL | sthings-u24     | 2024-05-05 |
| UBUNTU24 | RKE2-NODE   | VSPHERE | LABUL | sthings-u24-k8s | 2024-05-05 |
| ROCKY9   | BASE-OS     | VSPHERE | LABUL | sthings-r9      | 2024-05-01 |
| ROCKY9   | RKE2-NODE   | VSPHERE | LABUL | sthings-r9-k8s  |            |



## OS REQUIREMENTS

```
# INSTALL OS REQUIREMENTS
sudo apt install -y sshpass unzip
pip install ansible --upgrade

# INSTALL PACKER
wget https://releases.hashicorp.com/packer/1.10.2/packer_1.10.2_linux_amd64.zip
unzip packer_1.10.2_linux_amd64.zip
sudo mv packer /usr/bin/packer
sudo chmod +x /usr/bin/packer
```

## RENDER OS-TEMPLATE w/ machineShop

```bash
machineShop render \
--source local \
--template template/ubuntu23-vsphere.pkr.tpl.hcl \
--defaults environments/labul-vsphere.yaml \
--brackets square \
--values "vmTemplateName=ubuntu23-04-24, packerConfigMountPath=/home/sthings/packer/ubuntu23-labul-vsphere, ansiblePlayMountPath=/home/sthings/packer/ubuntu23-labul-vsphere, ansibleOsProvioning=base-os, osVersion=ubuntu23" \
--destination /home/sthings/packer/ubuntu23-labul-vsphere/ubuntu23.pkr.hcl \
--output file
```

## RENDER KICKSTART w/ machineShop

```bash
machineShop render \
--source local \
--template kickstart/ubuntu-vsphere.yaml \
--defaults environments/labul-vsphere.yaml \
--output file \
--destination /home/sthings/packer/ubuntu23-labul-vsphere/user-data
```

## RENDER PLAYBOOK w/ machineShop

```bash
machineShop render \
--source local \
--template ansible/play.yaml \
--defaults ansible/base-os.yaml \
--output file \
--brackets square \
--destination /home/sthings/packer/ubuntu23-labul-vsphere/base-os.yaml
```

## RENDER ANSIBLE REQUIREMENTS w/ machineShop

```bash
machineShop render \
--source local \
--template ansible/requirements.yaml \
--defaults environments/labul-vsphere.yaml \
--output file \
--brackets square \
--destination /home/sthings/packer/ubuntu23-labul-vsphere/requirements.yaml
```

## PACKER BUILD

```bash
cd /home/sthings/packer/ubuntu23-labul-vsphere/
touch meta-data
packer init ubuntu23.pkr.hcl
packer build -force -var "username=<USERNAME>" -var "password=<PASSWORD>" ubuntu23.pkr.hcl
```
