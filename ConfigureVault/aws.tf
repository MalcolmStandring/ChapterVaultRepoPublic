resource "vault_aws_secret_backend" "aws_backend" {
  access_key = var.AWS_access
  secret_key = var.AWS_secret
  region = var.AWS_region
  path = "aws"
}

resource "vault_generic_secret" "AWS_secrets_account" {
    path = "aws/config/root"

data_json = <<EOT
{
  "access_key": $(var.AWS_access},
  "secret_key": ${var.AWS_secret},
  "region": ${var.AWS_region}
}
EOT
}