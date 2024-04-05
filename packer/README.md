# stuttgart-things/packer

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
--defaults environments/labul-vsphere.yaml \
--output file \
--brackets square \
--destination /home/sthings/packer/ubuntu23-labul-vsphere/base-os.yaml
```

## RENDER PLAYBOOK w/ machineShop

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
