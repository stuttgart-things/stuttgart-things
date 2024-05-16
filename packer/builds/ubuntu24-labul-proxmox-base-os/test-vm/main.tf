module ubuntu24-labul-proxmox-base-os {
  source           = "github.com/stuttgart-things/proxmox-vm.git?ref=v2.9.14-1.5.5"
  vm_count         = 1
  vm_name          = var.vsphere_vm_name
  vm_memory        = "8192"
  vm_template      = var.vsphere_vm_template
  vm_disk_size     = "32G"
  vm_num_cpus      = "8"
  pve_cluster_node = "sthings-pve1"
  pve_datastore    = "sthings-pve1"
  pve_folder_path  = "stuttgart-things"
  pve_network      = "vmbr102"
  vm_notes         = "PROXMOX-VM PACKER TEST VM BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
  pve_api_url      = var.pve_api_url
  pve_api_user     = var.pve_api_user
  pve_api_password = var.pve_api_password
  vm_ssh_user      = var.vm_ssh_user
  vm_ssh_password  = var.vm_ssh_password
}

output "ip" {
  value     = module.ubuntu24-labul-proxmox-base-os.ip
}

variable "vsphere_vm_name" {
  type        = string
  description = "name of vsphere vm template"
}

variable "vsphere_vm_template" {
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
