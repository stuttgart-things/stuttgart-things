module "packer-test-vm" {
  source                 = "[[ .testVmModuleSource ]]"
  vm_count               = [[ .testVmCount ]]
  vsphere_vm_name        = "[[ .osVersion ]]-[[ .lab ]]-[[ .cloud ]]-testvm"
  vm_memory              = [[ .testVmRam ]]
  vsphere_vm_template    = var.vsphere_vm_template
}

variable "vsphere_vm_template" {
  default     = false
  type        = string
  description = "name of vsphere vm template"
}