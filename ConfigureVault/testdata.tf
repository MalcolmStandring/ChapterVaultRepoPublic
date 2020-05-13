resource "vault_generic_secret" "developer_sample_data01" {
  path = "${var.TestData_MountPath}/test_data/accounting/abe"

  data_json = <<EOT
{
  "username": "awilson",
  "password": "pass_abewilson",
  "fullname": "Abraham Wilson"
}
EOT
}

resource "vault_generic_secret" "developer_sample_data02" {
  path = "${var.TestData_MountPath}/test_data/accounting/mary"

  data_json = <<EOT
{
  "username": "msmith",
  "password": "pass_msmith",
  "fullname": "Mary Smith"
}
EOT
}

resource "vault_generic_secret" "developer_sample_data03" {
  path = "${var.TestData_MountPath}/test_data/finance/bob"

  data_json = <<EOT
{
  "username": "rmackay",
  "password": "pass_rmackay",
  "fullname": "Robert Mackay"
}
EOT
}

resource "vault_generic_secret" "developer_sample_data04" {
  path = "${var.TestData_MountPath}/test_data/finance/kaisha"

  data_json = <<EOT
{
  "username": "knodcek",
  "password": "pass_knodcek",
  "fullname": "Kaisha Nodcek"
}
EOT
}

resource "vault_generic_secret" "developer_sample_data05" {
  path = "${var.TestData_MountPath}/test_data/finance/cara"

  data_json = <<EOT
{
  "username": "cpatak",
  "password": "pass_cpatak",
  "fullname": "Cara Patak"
}
EOT
}

resource "vault_generic_secret" "developer_sample_data06" {
  path = "${var.TestData_MountPath}/test_data/development/phil"

  data_json = <<EOT
{
  "username": "pwilshaw",
  "password": "pass_pwilshaw",
  "fullname": "Phillip Wilshaw"
}
EOT
}

