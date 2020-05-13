resource "vault_identity_group" "admin_group" {
  name = "administrators"
  type = "internal"
  policies = [vault_policy.admin_policy.name]
}

resource "vault_identity_group" "provisioner_group" {
  name = "provisioners"
  type = "internal"
  policies = [vault_policy.provisioner_policy.name]
}

