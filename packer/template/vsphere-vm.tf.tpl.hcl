module [[ .osVersion ]]-[[ .lab ]]-[[ .cloud ]]-[[ .ansibleOsProvisioning ]] {
  source                 = "[[ .testVmModuleSource ]]"
  vm_count               = [[ .testVmCount ]]
  vsphere_vm_name        = var.vm_name
  vsphere_vm_template    = var.vm_template
  vm_memory              = [[ .testVmRam ]]
  vm_disk_size           = "[[ .testVmDiskSize ]]"
  vm_num_cpus            = [[ .testCpu ]]
  firmware               = "bios"
  vsphere_vm_folder_path = "[[ .folderPath ]]"
  vsphere_datacenter     = "[[ .testDatacenter ]]"
  vsphere_datastore      = "[[ .testDatastore ]]"
  vsphere_resource_pool  = "[[ .cluster ]]/Resources"
  vsphere_network        = "[[ .testNetwork ]]"
  bootstrap              = ["echo STUTTGART-THINGS"]
  annotation             = "[[ .testAnnotation ]] BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
  vsphere_server         = var.vsphere_server
  vsphere_user           = var.vsphere_user
  vsphere_password       = var.vsphere_password
  vm_ssh_user            = var.vm_ssh_user
  vm_ssh_password        = var.vm_ssh_password
}

variable "vm_name" {
  type        = string
  description = "name of vsphere vm template"
}

variable "vsphere_server" {
  type        = string
  description = "name of vsphere vm template"
}

variable "vm_template" {
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
  value = [module.[[ .osVersion ]]-[[ .lab ]]-[[ .cloud ]]-[[ .ansibleOsProvisioning ]].ip]
}
