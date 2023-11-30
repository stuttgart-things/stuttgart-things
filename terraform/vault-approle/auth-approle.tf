// ENABLE THE APPROLE AUTH METHOD
resource "vault_auth_backend" "approle" {
  type = "approle"
}

// CREATE A ROLE FOR WITH READ-ONLY POLICIES
resource "vault_approle_auth_backend_role" "read_only" {
  backend = vault_auth_backend.approle.path

  role_name = "read-only"
  token_policies = [
    vault_policy.read_all_kvv2.name,
    vault_policy.read_global.name,
  ]
}

// CREATE A ROLE WITH READ-WRITE POLICIES
resource "vault_approle_auth_backend_role" "read_write" {
  backend = vault_auth_backend.approle.path

  role_name = "read-write"
  token_policies = [
    vault_policy.read_write_all_kvv2.name,
    vault_policy.read_write_global.name,
  ]
}

data "vault_approle_auth_backend_role_id" "role" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.read_write.role_name
}

output "role-id" {
  value = data.vault_approle_auth_backend_role_id.role.role_id
}

resource "vault_approle_auth_backend_role_secret_id" "id" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.read_write.role_name
}

output "secret-id" {
  value = nonsensitive(resource.vault_approle_auth_backend_role_secret_id.id.secret_id)
}
