# stuttgart-things/packer

this file was created at: 2024-05-15 05:26

## INSTALL OS-REQUIREMENTS

```bash
# INSTALL OS REQUIREMENTS
sudo apt install -y sshpass unzip
pip install ansible --upgrade
```

## INSTALL PACKER

```bash
wget https://releases.hashicorp.com/packer/1.10.3/packer_1.10.3_linux_amd64.zip
unzip packer_1.10.3_linux_amd64.zip
sudo mv packer /usr/bin/packer
sudo chmod +x /usr/bin/packer
rm -rf packer_1.10.3_linux_amd64.zip
```

## CLONE/CHANGE TO CONFIG DIR

```bash
# CLONE FROM BRANCH
git clone --branch ubuntu22-labul-proxmox https://github.com/stuttgart-things/stuttgart-things

# OR CLONE FROM MAIN AFTER A PREVIOUS PR-MERGE
git clone https://github.com/stuttgart-things/stuttgart-things

# CHANGE TO DIR
cd stuttgart-things/packer/builds/ubuntu22-labul-proxmox/
```

## START PACKER BUILD

```bash
# ADD LOGGING
export PACKER_LOG_PATH="packerlog.txt"
export PACKER_LOG=1

# IF BUILD WITH FIXED IP IN CONFIG MAYBE NEEDED OR EDIT KNOWN HOSTS FILE
rm -rf ~/.ssh/known_hosts

packer init packer/builds/ubuntu22-labul-proxmox-base-os/ubuntu22-base-os.pkr.hcl

DATE=$(echo $(date +'%Y-%m-%d'))

packer build -force \
-var "name=${DATE}-ubuntu22-labul-proxmox" \
-var "password=<PASSWORD>" \
-var "password=<PASSWORD>" \
packer/builds/ubuntu22-labul-proxmox-base-os/ubuntu22-base-os.pkr.hcl
```

## TERRAFORM

```bash
TERRAFORM_VERSION=1.8.2
wget -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo unzip terraform.zip -d /usr/bin/
rm terraform.zip
terraform --version
```

```bash
# CHANGE TO TERRAFORM DIR
cd ubuntu22-labul-proxmox-base-os/test-vm/

# INITIALIZE TERRAFORM
export AWS_ACCESS_KEY_ID=<S3_USERNAME>
export AWS_SECRET_ACCESS_KEY=<S3_PASSWORD>

terraform init

# CREATE vars file
touch terraform.tfvars

# EXPORT SECRETS AND VM TEMPLATE NAME
export TF_VAR_vsphere_user=<CLOUD_USERNAME>
export TF_VAR_vsphere_password=<CLOUD_PASSWORD>
export TF_VAR_vm_ssh_user=<SSH_USERNAME>
export TF_VAR_vm_ssh_password=<SSH_PASSWORD>
export TF_VAR_vsphere_vm_template=<CLOUD_VM_TEMPLATE>

# DEPLOY INFRASTRUCTURE
terraform apply -auto-approve

# AFTER THE APPLY PROCESS CHECK THE IP-ADDRESS AND CONNECT TO THE VM
ssh <SSH_USERNAME>@<IP>

# DESTROY THE PROJECT
terraform destroy -auto-approve
```
