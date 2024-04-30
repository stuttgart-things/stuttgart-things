module ubuntu23-labul-vsphere-base-os {
  source                 = "github.com/stuttgart-things/vsphere-vm?ref=v1.7.5-2.7.0"
  vm_count               = 1
  vsphere_vm_name        = var.vsphere_vm_name
  vm_memory              = 8192
  vsphere_vm_template    = var.vsphere_vm_template
  vm_disk_size           = "32"
  vm_num_cpus            = 8
  firmware               = "bios"
  vsphere_vm_folder_path = "stuttgart-things/testing"
  vsphere_datacenter     = "/LabUL/"
  vsphere_datastore      = "/LabUL/host/Cluster-V6.5/10.31.101.41/UL-ESX-SAS-01"
  vsphere_resource_pool  = "/LabUL/host/Cluster-V6.5/Resources"
  vsphere_network        = "/LabUL/host/Cluster-V6.5/10.31.101.41/MGMT-10.31.101"
  bootstrap              = ["echo STUTTGART-THINGS"]
  annotation             = "PACKER VSPHERE TEST-VM BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
  vsphere_server         = var.vsphere_server
  vsphere_user           = var.vsphere_user
  vsphere_password       = var.vsphere_password
  vm_ssh_user            = var.vm_ssh_user
  vm_ssh_password        = var.vm_ssh_password
}

# ADDED LATER
variable "vsphere_vm_name" {
  type        = string
  description = "name of vsphere vm template"
}

# ADDED LATER
variable "vsphere_server" {
  type        = string
  description = "name of vsphere vm template"
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
  value = [module.ubuntu23-labul-vsphere-base-os.ip]
}
