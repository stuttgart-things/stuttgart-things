terraform {
  backend "s3" {

    endpoints = {
      s3 = "https://artifacts.app1.sthings-vsphere.labul.sva.de"
    }

    skip_requesting_account_id = true
    skip_s3_checksum = true
    key = "rocky9-awx-test2.tfstate"
    bucket = "proxmox-labul"
    region = "main"
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
    force_path_style = true
    workspace_key_prefix = "rocky9-awx-test2"
  }
}