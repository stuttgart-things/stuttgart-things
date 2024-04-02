# stuttgart-things/packer

## RENDER OS-TEMPLATE w/ machineShop

```bash
machineShop render \
--source local \
--template template/ubuntu23-pve.pkr.tpl.hcl \
--defaults environments/labul-pve.yaml \
--brackets square \
--values "vmTemplateName=u23"


mkdir -p ~/projects/packer/u23-labul-vsphere; machineShop render --source local --template template/ubuntu23-vsphere.pkr.tpl.hcl --defaults environments/labul-vsphere.yaml --brackets square --values "vmTemplateName=u23-04-24, packerConfigMountPath=~/projects/packer/u23-labul-vsphere, ansiblePlayMountPath=~/projects/packer/u23-labul-vsphere, ansibleOsProvioning=base-os, osVersion=ubuntu23" --destination ~/projects/packer/u23-labul-vsphere/u23.pkr.hcl --output file



```

## RENDER KICKSTART w/ machineShop

```bash
machineShop render \
--source local \
--template kickstart/ubuntu-vsphere.yaml \
--defaults environments/labul-vsphere.yaml
```

## RENDER PLAYBOOK w/ machineShop

```bash
machineShop render \
--source local \
--template kickstart/ubuntu-vsphere.yaml \
--defaults environments/labul-vsphere.yaml
```

## PACKER BUILD

```bash
touch meta-data
packer build -force -var "username=<USERNAME>" -var "password=<PASSWORD>" ubuntu23.pkr.hcl
```
