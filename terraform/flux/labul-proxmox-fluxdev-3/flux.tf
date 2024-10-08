module "labul-proxmox-fluxdev-3" {
  source            = "github.com/stuttgart-things/flux2-cluster-bootstrap?ref=2024.06.16"
  kubeconfig_path   = "/tmp/fluxdev-3"
  github_token      = var.github_token
  github_org        = "stuttgart-things"
  github_repository = "stuttgart-things"
  keep_namespace    = "true"
  components_extra  = []
  target_path       = "clusters/labul/proxmox/fluxdev-3"
  secrets = [
    {
      name = "sops-age"
      namespace = "flux-system"
      kvs = {
        "age.agekey" = var.age_key
      }
    },
  ]
  additional_manifests = [
    {
      content = <<-EOT
kind: Namespace
apiVersion: v1
metadata:
  name: flux-system
  labels:
    app: flux
EOT
    },
    {
      content = <<-EOT
apiVersion: v1
kind: ConfigMap
metadata:
  name: ca-pemstore
  namespace: flux-system
data:
  labul-pve.crt: |-
    -----BEGIN CERTIFICATE-----
    MIIFeDCCA2CgAwIBAgIUT4jkE73bE/rKLhh9k03K2uJ8EjowDQYJKoZIhvcNAQEL
    BQAwNzEMMAoGA1UEChMDU1ZBMRAwDgYDVQQLEwdzdGhpbmdzMRUwEwYDVQQDEwxs
    YWJ1bC5zdmEuZGUwHhcNMjMwMzE2MTMxNTUwWhcNMzMwMzEzMTMxNjE4WjA3MQww
    CgYDVQQKEwNTVkExEDAOBgNVBAsTB3N0aGluZ3MxFTATBgNVBAMTDGxhYnVsLnN2
    YS5kZTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAN1JiiHkUx88QRJF
    dkDTuw+G+uF8jm64OFP+a4dbay0BvUFNnfnBXRhcpGD1MKgPzHFLx0SU8MCq9gC0
    2Hh6mi2fh+/J8kjXleSm0BYexVfx3uHGxjt7mCHleaXeMZjmeDlMftIlEFLYYiyI
    xpQlN5wQ0Rat4QVC9TbueUczi3Uxr14eUkdkRXfIPVi+Swxhko5N7fFYie+xgKMn
    TqX7aWPIoCKXy20kGvOHfjo9rpoTdZ0RXg1ffQgvYPkZTqMHisgIYh+lqiLqdIlh
    Ur2jcwTBTPQEOKVGufMUvEOJj71GBXUHlqg28w1XYYFI6VuKtU/gipiwhGbjELJV
    i3nKInBxgxl+xnJ7RrtQ5fw0OfDQFhMZoj4YvrMzg6EWWYhYKerdOvJfdOKBOC5F
    e6tgponprhbjiIfMhUPeuuqtnXRFKHCf/yVK7cHQmXIGQt2iIKOqMdLnK6R8BCdr
    PKPh3x1JPFX6+2cbkP6DpcYSVMlP+vBgKyilBareHoCQEwa4EzchA/RznZuV3sNk
    BtQLvdNnOnT3/hOR97g8NpkRJbePkN5k8y2PpV3K9iu1gJQa+DOog1wki14inNiC
    eh1QDQp0CySseo7pDNvR2O1+mkmYgiCnh7lvuPj+BqF9j8hitg+n+Tw16qIOpJNe
    MKoxl35Hx8hDR3ucnpocx6OlORtdAgMBAAGjfDB6MA4GA1UdDwEB/wQEAwIBBjAP
    BgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSVJzNnN6HX5MwPoSJLGA/5b+tTWDAf
    BgNVHSMEGDAWgBSVJzNnN6HX5MwPoSJLGA/5b+tTWDAXBgNVHREEEDAOggxsYWJ1
    bC5zdmEuZGUwDQYJKoZIhvcNAQELBQADggIBAI6AospDzvYm0ciYwhxOI0Q1p2V+
    ruF1xCN/Khrlob8yNgUIkggFZGwclLN5RTteOlN83MdFUZjbBp2syW1ZZbhkAEC6
    wOkzIQ1EA0XaiX+SIIeFbxyuhziEKIlZScMz1ZPjdrUKevbcHWCRmYJ+K/Izjeii
    wFal1Z0y/d1zV0WO5g/B8XSmay7VNdNBLX47i7Sjps7rJpizSr2QhLC9IH4iFwWG
    CSX1rhLgNX9TkDTDmGXWCZ5VeVXydy3jVf3ykhcLQrI+viI66PDYPJ9lvKCYgegP
    WLqF+GfgFiwyDm5PFAiQxjwMcz0230m+kuAISoDSj283J5zhQZa+fsz/Wy9YVtRc
    Mpj8O6bg1dzkdhIw2aZ1/cMhw0463TxHXN/eeoKNZy7m7B7oqqqW181JtzB6LLiG
    5qP7TTBJExDmF83E7Fv10tz0DfTOQtnONCtqpYbgpuMRq/EBoMCNW3IXa5WfheR6
    tOYKFsy7wZpV/jpjpv8/za0eO8OZaP5YmLI/NVinPo+PplbmUNfQ4jy9c91Jzaes
    xddxTXnjm/w3cRUBZvThpp6B8yVTaSQWcxQZ7zh8pm3/Q7tXxTUB+PWGrYg2Ldz4
    iaxvLoCXCCGSKloGIiMQfEx87WUG1HI4RRd4SoWgVnIpMcxmREQeCw9XSrUEd2mj
    DGmlCM/e6VsZGsLz
    -----END CERTIFICATE-----
  labul-vsphere.crt: |-
    -----BEGIN CERTIFICATE-----
    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
    -----END CERTIFICATE-----
  labul.crt: |-
    -----BEGIN CERTIFICATE-----
    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
    -----END CERTIFICATE-----
EOT
    },
  ]

  kustomization_patches = <<-EOT
  ---
  apiVersion: kustomize.config.k8s.io/v1beta1
  kind: Kustomization
  resources:
    - gotk-components.yaml
    - gotk-sync.yaml
  patches:
    - patch: |
        - op: add
          path: /spec/decryption
          value:
            provider: sops
            secretRef:
              name: sops-age
      target:
        kind: Kustomization
        name: flux-system
    - patch: |
        - op: add
          path: /spec/template/spec/volumes/-
          value:
            name: ca-pemstore
            configMap:
              name: ca-pemstore
        - op: add
          path: /spec/template/spec/containers/0/volumeMounts/-
          value:
            name: ca-pemstore
            mountPath: /etc/ssl/certs/my-cert.pem
            subPath: labul-pve.crt
            readOnly: true
        - op: add
          path: /spec/template/spec/containers/0/volumeMounts/-
          value:
            name: ca-pemstore
            mountPath: /etc/ssl/certs/labul-vsphere.pem
            subPath: labul-vsphere.crt
            readOnly: true
      target:
        kind: Deployment
        name: source-controller
  EOT
}

variable "github_token" { type= string }
variable "age_key" { type= string }