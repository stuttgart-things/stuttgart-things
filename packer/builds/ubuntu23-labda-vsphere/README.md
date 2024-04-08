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

## PACKER BUILD

```bash
git clone --branch ubuntu23-labda-vsphere https://github.com/stuttgart-things/stuttgart-things
cd /home/sthings/packer/ubuntu23-labda-vsphere/
packer init ubuntu23.pkr.hcl
packer build -force -var "username=<USERNAME>" -var "password=<PASSWORD>" ubuntu23.pkr.hcl
```
