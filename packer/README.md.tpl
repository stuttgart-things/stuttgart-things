# stuttgart-things/packer

## OS REQUIREMENTS

```bash
# INSTALL OS REQUIREMENTS
sudo apt install -y sshpass unzip
pip install ansible --upgrade
```

## INSTALL PACKER

```bash
wget https://releases.hashicorp.com/packer/[[ .packerVersion ]]/packer_[[ .packerVersion ]]_linux_amd64.zip
unzip packer_[[ .packerVersion ]]_linux_amd64.zip
sudo mv packer /usr/bin/packer
sudo chmod +x /usr/bin/packer
```

## PACKER BUILD

```bash
git clone --branch [[ .osVersion ]]-[[ .lab ]]-[[ .cloud ]] https://github.com/stuttgart-things/stuttgart-things
cd packer/builds/[[ .osVersion ]]-[[ .lab ]]-[[ .cloud ]]/
rm -rf ~/.ssh/known_hosts
export PACKER_LOG_PATH="packerlog.txt"
export PACKER_LOG=1
packer init [[ .osVersion ]].pkr.hcl
packer build -force -var "username=<USERNAME>" -var "password=<PASSWORD>" [[ .osVersion ]].pkr.hcl
```
