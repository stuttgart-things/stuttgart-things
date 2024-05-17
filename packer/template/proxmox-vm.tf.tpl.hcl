module [[ .osVersion ]]-[[ .lab ]]-[[ .cloud ]]-[[ .ansibleOsProvisioning ]] {
  source           = "[[ .testVmModuleSource ]]"
  vm_count         = [[ .testVmCount ]]
  vm_name          = var.vm_name
  vm_template      = var.vm_template
  vm_memory        = "[[ .testVmRam ]]"
  vm_disk_size     = "[[ .testVmDiskSize ]]"
  vm_num_cpus      = "[[ .testCpu ]]"
  pve_cluster_node = "[[ .testVmDatacenter ]]"
  pve_datastore    = "[[ .testVmDatastore ]]"
  pve_folder_path  = "[[ .testVmFolder ]]"
  pve_network      = "[[ .testVmNetwork ]]"
  vm_notes         = "PROXMOX-VM PACKER TEST VM BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
  pve_api_url      = var.pve_api_url
  pve_api_user     = var.pve_api_user
  pve_api_password = var.pve_api_password
  vm_ssh_user      = var.vm_ssh_user
  vm_ssh_password  = var.vm_ssh_password
}

output "ip" {
  value     = module.[[ .osVersion ]]-[[ .lab ]]-[[ .cloud ]]-[[ .ansibleOsProvisioning ]].ip
}

variable "vm_name" {
  type        = string
  description = "name of vsphere vm template"
}

variable "vm_template" {
  type        = string
  description = "name of proxmox vm template"
}

variable "pve_api_url" {
  type        = string
  description = "url of proxmox api. Example: https://server-example.sva.de:8006/api2/json"
}

variable "pve_api_user" {
  type        = string
  description = "username of proxmox api user"
}

variable "pve_api_password" {
  type        = string
  description = "password of proxmox api user"
}

variable "vm_ssh_user" {
  type        = string
  description = "desired username for ssh connection"
}

variable "vm_ssh_password" {
  type        = string
  description = "desired password for ssh connection"
}
