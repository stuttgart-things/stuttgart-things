terraform {
  backend "s3" {

    endpoints = {
      s3 = "{{ .s3Endpoint }}"
    }

    skip_requesting_account_id = true
    skip_s3_checksum = true
    key = "{{ .stateKey }}.tfstate"
    bucket = "{{ .s3Bucket }}"
    region = "{{ .s3Region }}"
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
    force_path_style = true
    workspace_key_prefix = "{{ .stateKey }}"
  }
}