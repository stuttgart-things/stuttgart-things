module "awx-bastion" {
  source                 = "github.com/stuttgart-things/vsphere-vm?ref=v1.7.5-2.7.0-1"
  vm_count               = 1
  vsphere_vm_name        = "awx-bastion"
  vm_memory              = 8192
  vsphere_vm_template    = "sthings-u24"
  vm_disk_size           = "96"
  vm_num_cpus            = 6
  firmware               = "bios"
  vsphere_vm_folder_path = "stuttgart-things/infra"
  vsphere_datacenter     = "/LabUL"
  vsphere_datastore      = "/LabUL/datastore/UL-ESX-SAS-01"
  vsphere_resource_pool  = "/LabUL/host/Cluster-V6.5/Resources"
  vsphere_network        = "/LabUL/network/MGMT-10.31.101"
  bootstrap              = ["echo STUTTGART-THINGS"]
  annotation             = "VSPHERE-VM awx-bastion sthings-u24 BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
  vsphere_server         = var.vsphere_server
  vsphere_user           = var.vsphere_user
  vsphere_password       = var.vsphere_password
  vm_ssh_user            = var.vm_ssh_user
  vm_ssh_password        = var.vm_ssh_password
}

variable "vsphere_server" {
  default     = false
  type        = string
  description = "name of vsphere vm server"
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
  value = [module.awx-bastion.ip]
}
