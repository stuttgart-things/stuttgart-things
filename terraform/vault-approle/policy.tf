// create an admin policy
resource "vault_policy" "admin" {
  name = "admin"

  policy = file("./templates/admin.hcl")
}

// allow reading kvv2 of all k8s clusters
resource "vault_policy" "read_all_kvv2" {
  name = "read-all-kvv2"

  policy = <<EOF
path "kvv2-*/*" {
    capabilities = ["list", "read"]
}
EOF
}

// allow reading and writing kvv2 of all k8s clusters
resource "vault_policy" "read_write_all_kvv2" {
  name = "read-write-all-kvv2"

  policy = <<EOF
path "kvv2-*/*" {
    capabilities = ["create", "read", "update", "patch", "list"]
}
EOF
}

// allow reading from global secret store, e.g. under "secret/"
resource "vault_policy" "read_global" {
  name = "read-global"

  policy = templatefile("./templates/read_global.tpl", {
    kvv2_mount_path = vault_mount.kvv2.path
  })
}

// allow reading and writing of global secret store, e.g. under "secret/"
resource "vault_policy" "read_write_global" {
  name = "read-write-global"

  policy = templatefile("./templates/read_write_global.tpl", {
    kvv2_mount_path = vault_mount.kvv2.path
  })
}
