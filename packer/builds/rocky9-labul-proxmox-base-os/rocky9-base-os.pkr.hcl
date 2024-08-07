packer {
  required_version = ">= 1.10.3"
  required_plugins {
    proxmox = {
      source  = "github.com/hashicorp/proxmox"
      version = ">= 1.1.7"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

source "proxmox-iso" "autogenerated_1" {
  boot                    = "order=virtio0;ide2;net0"
  boot_command            = ["<tab> inst.text inst.ks=cdrom:sr1:/user-data<enter><wait>"]
  boot_wait               = "5s"
  cloud_init              = "false"
  cloud_init_storage_pool = "datastore"
  cores                   = 8
  cpu_type                = "host"
  scsi_controller         = "virtio-scsi-pci"

  disks {
    disk_size         = "16G"
    format            = "raw"
    storage_pool      = "datastore"
    type              = "virtio"
  }

  additional_iso_files {
    cd_files = ["./meta-data", "./user-data"]
    cd_label = "cidata"
    unmount = true
    iso_storage_pool = "local"
  }

  insecure_skip_tls_verify = true
  iso_checksum             = "ee3ac97fdffab58652421941599902012179c37535aece76824673105169c4a2"
  iso_storage_pool         = "datastore"
  iso_url                  = "https://dl.rockylinux.org/pub/rocky/9.4/isos/x86_64/Rocky-9.4-x86_64-minimal.iso"
  memory                   = 8192

  network_adapters {
    bridge = "vmbr103"
    model  = "virtio"
  }

  node                 = "sthings-pve1"
  os                   = "l26"
  username             = var.username
  password             = var.password
  pool                 = "packer"
  proxmox_url          = "https://sthings-pve1.labul.sva.de:8006/api2/json"
  ssh_username         = "root"
  ssh_password         = "ch0coLate"
  ssh_timeout          = "20m"
  template_description = "Packer VM Template\n---\nSpecs  \nOS: rocky9  \nBuild Date: ${local.packerstarttime}\n---\nProvisioning \nMaintainer  \nPatrick Hermann patrick.hermann@sva.de \nChristian Mueller christian.mueller@sva.de \nMartin Wolf martin.wolf@sva.de\n---"
  template_name        = "${ var.name }"
  unmount_iso          = true
}

build {
  sources = ["source.proxmox-iso.autogenerated_1"]

  provisioner "shell" {
    inline = ["dnf update -y; dnf install -y python3-dnf cloud-utils-growpart; dnf install -y qemu-guest-agent cloud-init; dnf install -y gdisk python3; shred -u /etc/ssh/*_key /etc/ssh/*_key.pub; rm -f /var/run/utmp; >/var/log/lastlog; >/var/log/wtmp; >/var/log/btmp; rm -rf /tmp/* /var/tmp/*; unset HISTFILE; rm -rf /home/*/.*history /root/.*history; rm -f /root/*ks; passwd -d root; passwd -l root; rm -f /etc/resolv.conf; ln -sf /run/NetworkManager/resolv.conf /etc/resolv.conf; echo manage_PasswordAuthentication ;sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config"]
  }

  provisioner "ansible" {
    ansible_env_vars       = ["ANSIBLE_REMOTE_TEMP=/tmp", "ANSIBLE_HOST_KEY_CHECKING=False", "ANSIBLE_SSH_ARGS=-oForwardAgent=yes -oControlMaster=auto -oControlPersist=60s -oHostKeyAlgorithms=+ssh-rsa   -oPubkeyAcceptedKeyTypes=+ssh-rsa", "ANSIBLE_NOCOLOR=True"]
    extra_arguments        = ["--scp-extra-args", "'-O'", "-e ansible_ssh_pass=ch0coLate -vv"]
    keep_inventory_file    = "true"
    playbook_file          = "./base-os.yaml"
    user                   = "root"
    galaxy_file            = "./requirements.yaml"
    galaxy_force_install   = "true"
  }

}

locals {
  packerstarttime = formatdate("YYYY-MM-DD", timestamp())
  vmdate = formatdate("YYMM", timestamp())
}

variable "password" {
  type = string
}

variable "username" {
  type = string
}

variable "name" {

  type = string
}
