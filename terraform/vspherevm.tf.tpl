module "{{ .vmName }}" {
  source   = "github.com/stuttgart-things/vsphere-vm?ref=v1.7.5-2.7.0"
  vm_count = {{ .vmCount }}
}