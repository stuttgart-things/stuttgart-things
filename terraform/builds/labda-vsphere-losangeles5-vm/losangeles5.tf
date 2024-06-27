module "losangeles5" {
  source                 = "github.com/stuttgart-things/vsphere-vm?ref=v1.7.5-2.7.0-1"
  vm_count               = 1
  vsphere_vm_name        = "losangeles5"
  vm_memory              = 8192
  vsphere_vm_template    = "ubuntu22"
  vm_disk_size           = "96"
  vm_num_cpus            = 6
  firmware               = "bios"
  vsphere_vm_folder_path = "stuttgart-things/testing"
  vsphere_datacenter     = "/NetApp-HCI-Datacenter"
  vsphere_datastore      = "/NetApp-HCI-Datacenter/datastore/DatastoreCluster/NetApp-HCI-Datastore-02"
  vsphere_resource_pool  = "Resources"
  vsphere_network        = "/NetApp-HCI-Datacenter/network/tiab-prod"
  bootstrap              = ["echo STUTTGART-THINGS"]
  annotation             = "VSPHERE-VM losangeles5 ubuntu22 BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
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
  value = [module.losangeles5.ip]
}
