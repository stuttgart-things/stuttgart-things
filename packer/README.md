# stuttgart-things/packer

## RENDER TEMPLATE w/ machineShop

```bash
machineshop render \
--source local \
--template packer/os/ubuntu23-pve.pkr.tpl.hcl \
--defaults /home/sthings/projects/github/stuttgart-things/packer/environments/labul-pve.yaml \
--brackets square \
--values "vmTemplateName=u23"
```

## PACKER BUILD

```bash
touch meta-data
packer build -force -var "username=<USERNAME>" -var "password=<PASSWORD>" ubuntu23.pkr.hcl
```

