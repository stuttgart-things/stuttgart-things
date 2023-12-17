# stuttgart-things/packer

## RENDER TEMPLATE w/ machineShop

```bash
machineShop render \
--source local \
--template template/ubuntu23-pve.pkr.tpl.hcl \
--defaults environments/labul-pve.yaml \
--brackets square \
--values "vmTemplateName=u23"
```

## RENDER TEMPLATE w/ machineShop

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
