resource "vault_policy" "admin_policy" {
  name   = "admins"
  policy = file("policies/admin_policy.hcl")
}

resource "vault_policy" "provisioner_policy" {
  name   = "provisioners"
  policy = file("policies/provisioner-policy.hcl")
}