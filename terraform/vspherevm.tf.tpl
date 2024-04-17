module "{{ .vmName }}" {
  source   = "github.com/stuttgart-things/vsphere-vm?ref=v1.7.5-2.7.0"
  vm_count = {{ .vmCount }}
  vsphere_vm_name = {{ .vmName }}
  vm_memory = {{ .vmMemory }}
  vsphere_vm_template = {{ .vmTemplate }}
  vm_disk_size = {{ .vmDisk }}
  vm_num_cpus = {{ .vmCpu }}
  firmware = {{ .vmFirmware }}
  vsphere_vm_folder_path = {{ .vmFolder }}
  vsphere_datacenter = {{ .datacenter }}
  vsphere_datastore = {{ .vmDatastore }}
  vsphere_resource_pool = {{ .resourcePool }}
  vsphere_network = {{ .vmNetwork }}
  bootstrap = ["echo STUTTGART-THINGS"]
  annotation = "VSPHERE-VM {{ .vmName }} {{ .vmTemplate }} BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
}
