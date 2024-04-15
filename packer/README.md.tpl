# stuttgart-things/packer

this file was created at: [[ .date ]]

## INSTALL OS-REQUIREMENTS

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
rm -rf packer_[[ .packerVersion ]]_linux_amd64.zip
```

## CLONE/CHANGE TO CONFIG DIR

```bash
# CLONE FROM BRANCH
git clone --branch [[ .osVersion ]]-[[ .lab ]]-[[ .cloud ]] https://github.com/stuttgart-things/stuttgart-things

# OR CLONE FROM MAIN AFTER A PREVIOUS PR-MERGE
git clone https://github.com/stuttgart-things/stuttgart-things

# CHANGE TO DIR
cd stuttgart-things/packer/builds/[[ .osVersion ]]-[[ .lab ]]-[[ .cloud ]]/
```

## START PACKER BUILD

```bash
# ADD LOGGING
export PACKER_LOG_PATH="packerlog.txt"
export PACKER_LOG=1

# IF BUILD WITH FIXED IP IN CONFIG MAYBE NEEDED OR EDIT KNOWN HOSTS FILE
rm -rf ~/.ssh/known_hosts

packer init [[ .hclConfig ]].pkr.hcl

DATE=$(echo $(date +'%Y-%m-%d'))

packer build -force \
-var "name=${DATE}-[[ .osVersion ]]-[[ .lab ]]-[[ .cloud ]]" \
-var "password=<PASSWORD>" \
-var "password=<PASSWORD>" \
[[ .hclConfig ]].pkr.hcl
```

## TERRAFORM

```bash
#go to the folder where main.tf is located  
cd [[ .osVersion ]]-[[ .lab ]]-[[ .cloud ]]-[[ .ansibleOsProvisioning ]]/test-vm/

touch terraform.tfvars

terraform init

#export Secrets and VM Template
export TF_VAR_vsphere_user=<CLOUD_USERNAME>
export TF_VAR_vsphere_password=<CLOUD_PASSWORD>
export TF_VAR_vm_ssh_user=<SSH_USERNAME>
export TF_VAR_vm_ssh_password=<SSH_PASSWORD>
export TF_VAR_vsphere_vm_template=<CLOUD_VM_TEMPLATE>

terraform apply

#after the apply process check the ip-address and connect to the vm
```