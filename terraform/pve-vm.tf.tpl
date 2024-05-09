module "proxmox-vm" {
  source                  = "git::https://github.com/stuttgart-things/proxmox-vm.git?ref=v2.9.14-1.5.5"
  pve_api_url             = var.pve_api_url
  pve_api_user            = var.pve_api_user
  pve_api_password        = var.pve_api_password
  pve_api_tls_verify      = var.pve_api_tls_verify
  pve_cluster_node        = "sthings-pve1"
  pve_datastore           = "datastore"
  pve_folder_path         = "stuttgart-things"
  pve_network             = "vmbr101"
  vm_count                = 1
  vm_name                 = "vm-test-name"
  vm_notes                = "vm-info"
  vm_template             = "ubuntu22"
  vm_num_cpus             = "4"
  vm_memory               = "4096"
  vm_disk_size            = "32G"
  vm_ssh_user             = var.vm_ssh_user
  vm_ssh_password         = var.vm_ssh_password
}

output "ip" {
  value     = module.proxmox-vm.ip
}

output "mac" {
  value     = module.proxmox-vm.mac
}

output "id" {
  value     = module.proxmox-vm.id
}

variable "pve_api_url" {
  description = "url of proxmox api. Example: https://server-example.sva.de:8006/api2/json"
}
 
variable "pve_api_user" {
  description = "username of proxmox api user"
}
 
variable "pve_api_password" {
  description = "password of proxmox api user"
}
 
variable "vm_ssh_user" {
  description = "desired username for ssh connection"
}
 
variable "vm_ssh_password" {
  description = "desired password for ssh connection"
}
 
variable "pve_api_tls_verify" {
  description = "proxmox API disable check if cert is valid"
}
