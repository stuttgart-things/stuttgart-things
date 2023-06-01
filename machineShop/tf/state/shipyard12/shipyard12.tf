module "shipyard12" {
  vm_count = 1
  vsphere_vm_name = "shipyard12"
  vm_memory = 8192
  vm_disk_size = "96"
  vm_num_cpus = 6
  firmware = "bios"
  vsphere_vm_folder_path = var.vsphere_vm_folder_path
  source = "https://artifacts.tiab.labda.sva.de/modules/vsphere-vm.zip"
  vsphere_datacenter = var.vsphere_datacenter
  vsphere_datastore = var.vsphere_datastore
  vsphere_resource_pool = var.vsphere_resource_pool
  vsphere_network = var.vsphere_network
  vsphere_vm_template = var.vsphere_vm_template
  vm_ssh_user = var.vm_ssh_user
  vm_ssh_password = var.vm_ssh_password
  bootstrap = ["echo STUTTGART-THINGS"]
  annotation = "VSPHERE-VM BUILD w/ SHIPYARD FOR STUTTGART-THINGS"
}

#provider

terraform {
  backend "s3" {
    endpoint = "https://artifacts.labul.sva.de"
    key = "vm-shipyard12.tfstate"
    region = "main"
    bucket = "vsphere-vm"
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
    force_path_style = true
}

required_providers {
  vsphere = {
    source = "hashicorp/vsphere"
    version = ">= 2.3.1"
  }

}
  required_version = ">= 1.3.7"
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

#variables

variable "vsphere_server" {
  default     = false
  description = "vsphere server"
}

variable "vsphere_user" {
  default     = false
  description = "password of vsphere user"
}

variable "vsphere_password" {
  default     = false
  description = "password of vsphere user"
}

variable "vm_ssh_user" {
  default     = false
  description = "username of ssh user for vm"
}

variable "vm_ssh_password" {
  default     = false
  description = "password of ssh user for vm"
}

variable "vsphere_datastore" {
  default     = false
  description = "name of vsphere datastore"
}

variable "vsphere_datacenter" {
  default     = false
  description = "name of vsphere datacenter"
}

variable "vsphere_resource_pool" {
  default     = false
  description = "name of vsphere resource pool"
}

variable "vsphere_network" {
  default     = false
  description = "name of vsphere network"
}

variable "vsphere_vm_template" {
  default     = false
  description = "name/path of vsphere vm template"
}

variable "vsphere_vm_folder_path" {
  default     = false
  description = "folder path of to be created vm on datacenter"
}

#output

output "shipyard12_ip" {
  value = module.shipyard12.ip
}
