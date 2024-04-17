module "{{ .vmName }}" {
  source   = "github.com/stuttgart-things/vsphere-vm?ref=v1.7.5-2.7.0"
  vm_count = {{ .vmCount }}
  vsphere_vm_name = "{{ .vmName }}"
  vm_memory = {{ .vmMemory }}
  vsphere_vm_template = "{{ .vmTemplate }}"
  vm_disk_size = "{{ .vmDisk }}"
  vm_num_cpus = {{ .vmCpu }}
  firmware = "{{ .vmFirmware }}"
  vsphere_vm_folder_path = "{{ .vmFolder }}"
  vsphere_datacenter = "{{ .datacenter }}"
  vsphere_datastore = "{{ .vmDatastore }}"
  vsphere_resource_pool = "{{ .resourcePool }}"
  vsphere_network = "{{ .vmNetwork }}"
  bootstrap = ["echo STUTTGART-THINGS"]
  annotation = "VSPHERE-VM {{ .vmName }} {{ .vmTemplate }} BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
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
  value = [module.ubuntu23-labul-vsphere-base-os.ip]
}
