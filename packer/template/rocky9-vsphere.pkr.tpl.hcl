packer {
  required_version = ">= [[ .rocky9PackerMinVersion ]]"
  required_plugins {
    vmware = {
      version = ">= [[ .rocky9PackerVMwarePluginMinVersion ]]"
      source  = "[[ .vmWareProvider ]]"
    }
    ansible = {
      source  = "[[ .ansibleProvisioner ]]"
      version = ">= [[ .ansibleProvisionerMinVersion ]]"
    }
  }

}

source "vsphere-iso" "autogenerated_1" {
  CPUs                 = [[ .cpu ]]
  RAM                  = [[ .ram ]]
  RAM_reserve_all      = true
  boot_command         = ["<up><wait5><tab> inst.text inst.repo=cdrom:sr0 inst.ks=cdrom:sr1:/user-data<enter><wait>"]
  boot_order           = "disk,cdrom"
  boot_wait            = "[[ .bootWait ]]"
  cd_files             = ["[[ .packerConfigMountPath ]]/user-data"]
  cd_label             = "cidata"
  cluster              = "[[ .cluster ]]"
  convert_to_template  = "true"
  datastore            = "[[ .datastore ]]"
  disk_controller_type = ["pvscsi"]
  folder               = "[[ .folder ]]"
  guest_os_type        = "centos7_64Guest"
  host                 = "[[ .host ]]"
  insecure_connection  = "true"
  ip_wait_timeout      = "[[ .ipWaitTimeout ]]"
  iso_checksum         = "[[ .rocky9IsoChecksum ]]"
  iso_urls             = ["[[ .rocky9IsoUrl ]]"]
  network_adapters {
    network      = "[[ .network ]]"
    network_card = "vmxnet3"
  }
  notes                = "stuttgart-things/[[ .osVersion ]]\n\nBuild Date: ${local.packerstarttime} w/ packer\nOS: [[ .osVersion ]]\nISO: [[ .rocky9IsoUrl ]]\nProvisioning: [[ .ansibleOsProvioning ]]\n\n/[[ .templateCreator ]]"
  password               = "${var.password}"
  ssh_handshake_attempts = "[[ .sshHandshakeAttempts ]]"
  ssh_password           = "[[ .rocky9tmpSSHPassword ]]"
  ssh_timeout            = "[[ .sshTimeout ]]"
  ssh_username           = "[[ .rocky9tmpSSHUser ]]"
  storage {
    disk_size             = [[ .diskSize ]]
    disk_thin_provisioned = [[ .diskThinProvisioned ]]
  }
  username       = "${var.username}"
  vcenter_server = "[[ .vcenterServer ]]"
  vm_name        = "[[ .vmTemplateName ]]"
}

build {
  sources = ["source.vsphere-iso.autogenerated_1"]

  provisioner "shell" {
    inline = ["[[ .rocky9ShellCmd ]]"]
  }

  provisioner "ansible" {
    ansible_env_vars       = ["ANSIBLE_REMOTE_TEMP=/tmp", "ANSIBLE_HOST_KEY_CHECKING=False", "ANSIBLE_SSH_ARGS=-oForwardAgent=yes -oControlMaster=auto -oControlPersist=60s -oHostKeyAlgorithms=+ssh-rsa   -oPubkeyAcceptedKeyTypes=+ssh-rsa", "ANSIBLE_NOCOLOR=True"]
    extra_arguments        = ["--scp-extra-args", "'-O'"]
    keep_inventory_file    = "true"
    playbook_file          = "[[ .ansiblePlayMountPath ]]/[[ .ansibleOsProvioning ]].yaml"
    user                   = "[[ .rocky9tmpSSHUser ]]"
  }
}

locals {
  packerstarttime = formatdate("YYYYMMDD", timestamp())
}

variable "password" {
  type = string
}

variable "username" {
  type = string
}