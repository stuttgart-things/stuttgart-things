---
configmaps:
  packer:
    ubuntu23-vsphere.pkr.hcl: |
      packer {
        required_version = ">= {{ .ubuntu23PackerMinVersion }}"
