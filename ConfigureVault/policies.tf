resource "vault_policy" "admin_policy" {
  name   = "admins"
  policy = file("policies/admin_policy.hcl")
}

resource "vault_policy" "provisioner_policy" {
  name   = "provisioners"
  policy = file("policies/provisioner-policy.hcl")
}

resource "vault_policy" "operations_policy" {
  name = "operations"
  policy = file("policies/operations_policy.hcl")
}

resource "vault_policy" "developer_policy" {
  name = "developers"
  policy = file("policies/developer_policy.hcl")
}

