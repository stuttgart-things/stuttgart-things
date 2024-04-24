module ubuntu23-labda-vsphere-base-os {
  source                 = "github.com/stuttgart-things/vsphere-vm?ref=v1.7.5-2.7.0"
  vm_count               = 1
  vsphere_vm_name        = "ubuntu23-labda-vsphere-testvm"
  vm_memory              = 8192
  vsphere_vm_template    = var.vsphere_vm_template
  vm_disk_size           = "32"
  vm_num_cpus            = 8
  firmware               = "bios"
  vsphere_vm_folder_path = "stuttgart-things/infra"
  vsphere_datacenter     = "/NetApp-HCI-Datacenter/"
  vsphere_datastore      = "/NetApp-HCI-Datacenter/host/NetApp-HCI-Cluster-01/10.100.135.44//nfs06"
  vsphere_resource_pool  = "/NetApp-HCI-Datacenter/host/NetApp-HCI-Cluster-01/Resources"
  vsphere_network        = "/NetApp-HCI-Datacenter/host/NetApp-HCI-Cluster-01/10.100.135.44/tiab-prod"
  bootstrap              = ["echo STUTTGART-THINGS"]
  annotation             = "VSPHERE-VM BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
  vsphere_server         = "10.100.135.50"
  vsphere_user           = var.vsphere_user
  vsphere_password       = var.vsphere_password
  vm_ssh_user            = var.vm_ssh_user
  vm_ssh_password        = var.vm_ssh_password
}

variable "vsphere_vm_template" {
  default     = false
  type        = string
  description = "name of vsphere vm template"
}

variable "vm_ssh_user" {
  default     = false
  type        = string
  description = "username of ssh user for vm"
}

variable "vm_ssh_password" {
  default     = false
  type        = string
  description = "password of ssh user"
  }

variable "vsphere_user" {
  default     = false
  type        = string
  description = "password of vsphere user"
}

variable "vsphere_password" {
  default     = false
  type        = string
  description = "password of vsphere user"
}

output "ip" {
  value = [module.ubuntu23-labda-vsphere-base-os.ip]
}
