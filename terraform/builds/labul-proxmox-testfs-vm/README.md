# stuttgart-things/terraform

this file was created at: 2024-05-27, 07:36

## TERRAFORM

```bash
TERRAFORM_VERSION="1.7.5"
wget -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo unzip terraform.zip -d /usr/bin/
rm terraform.zip
terraform --version
```

```bash
# CHANGE TO DIR
cd builds/proxmoxvm/labul/testfs/

# INITIALIZE TERRAFORM
terraform init

# EXPORT SECRETS AND VM TEMPLATE NAME
export TF_VAR_vsphere_user=<CLOUD_USERNAME>
export TF_VAR_vsphere_password=<CLOUD_PASSWORD>
export TF_VAR_vsphere_server=<VSPHERE_SERVER>
export TF_VAR_vm_ssh_user=<SSH_USERNAME>
export TF_VAR_vm_ssh_password=<SSH_PASSWORD>
export TF_VAR_vsphere_vm_template=<CLOUD_VM_TEMPLATE>

export AWS_ACCESS_KEY_ID=<ACCESS_KEY>
export AWS_SECRET_ACCESS_KEY=<SECRET_KEY>

# DEPLOY INFRASTRUCTURE
terraform apply -auto-approve

# AFTER THE APPLY PROCESS CHECK THE IP-ADDRESS AND CONNECT TO THE VM
ssh <SSH_USERNAME>@<IP>

# DESTROY THE PROJECT
terraform destroy -auto-approve