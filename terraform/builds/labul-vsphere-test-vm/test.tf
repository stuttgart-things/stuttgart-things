module "test" {
  source   = "github.com/stuttgart-things/vsphere-vm?ref=v1.7.5-2.7.0"
  vm_count = 1
  vsphere_vm_name = "test"
  vm_memory = 4096
  vsphere_vm_template = "sthings-u23"
  vm_disk_size = "32"
  vm_num_cpus = 2
  firmware = "bios"
  vsphere_vm_folder_path = "stuttgart-things/testing"
  vsphere_datacenter = "/LabUL"
  vsphere_datastore = "/LabUL/datastore/UL-ESX-SAS-02"
  vsphere_resource_pool = "/LabUL/host/Cluster-V6.5/Resources"
  vsphere_network = "/LabUL/network/MGMT-10.31.101"
  bootstrap = ["echo STUTTGART-THINGS"]
  annotation = "VSPHERE-VM test sthings-u23 BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
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
  value = [module.test.ip]
}
