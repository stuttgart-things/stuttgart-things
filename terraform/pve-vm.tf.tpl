module "{{ .vmName }}" {
  source                  = "github.com/stuttgart-things/proxmox-vm.git?ref=v2.9.14-1.5.5"
  vm_count                = {{ .vmCount }}
  vm_name                 = "{{ .vmName }}"
  vm_memory               = "{{ .vmMemory }}"
  vm_num_cpus             = "{{ .vmCpu }}"
  vm_disk_size            = "{{ .vmDisk }}G"
  vm_template             = "{{ .vmTemplate }}"
  pve_cluster_node        = "{{ .pveClusterNode }}"
  pve_datastore           = "{{ .vmDatastore }}"
  pve_folder_path         = "{{ .vmFolder }}"
  pve_network             = "{{ .vmNetwork }}"
  vm_notes                = "VSPHERE-VM {{ .vmName }} {{ .vmTemplate }} BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
  pve_api_url             = var.pve_api_url
  pve_api_user            = var.pve_api_user
  pve_api_password        = var.pve_api_password
  vm_ssh_user             = var.vm_ssh_user
  vm_ssh_password         = var.vm_ssh_password
}

output "ip" {
  value     = module.{{ .vmName }}.ip
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
