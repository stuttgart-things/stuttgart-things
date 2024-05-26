module "xplane-dev2" {
  source            = "github.com/stuttgart-things/flux2-cluster-bootstrap"
  kubeconfig_path   = "/tmp/xplane-dev2"
  github_token      = var.github_token
  github_repository = "stuttgart-things"
  github_org        = "stuttgart-things"
  target_path       = "clusters/labul/vsphere/xplane-dev2"
  secrets = [
    {
      name = "sops-age"
      namespace = "flux-system"
      kvs = {
        "age.agekey" = var.age_key
      }
    },
  ]
}

variable "github_token" { type= string }
variable "age_key" { type= string }