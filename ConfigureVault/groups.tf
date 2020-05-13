resource "vault_identity_group" "admin_group" {
  name = "administrators"
  policies = [vault_policy.admin_policy.name]
}

resource "vault_identity_group" "provisioner_group" {
  name = "provisioners"
  policies = [vault_policy.provisioner_policy.name]
}
resource "vault_identity_group" "developer_group" {
  name = "developers"
  policies = [vault_policy.developer_policy.name]
}
