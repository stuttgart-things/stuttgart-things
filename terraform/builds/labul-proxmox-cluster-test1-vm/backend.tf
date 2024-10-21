terraform {
  backend "s3" {

    endpoints = {
      s3 = "https://artifacts.homerun-dev.sthings-vsphere.labul.sva.de"
    }

    skip_requesting_account_id = true
    skip_s3_checksum = true
    key = "cluster-test1.tfstate"
    bucket = "proxmoxvm-labul"
    region = "main"
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
    force_path_style = true
    workspace_key_prefix = "cluster-test1"
  }
}