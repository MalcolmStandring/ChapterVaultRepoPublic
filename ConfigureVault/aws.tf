# Configure AWS Secret Backend for Vault. An API key for a valid IAM user is required, along with the region. 
# The Vault path is currently hard-coded as "aws/"".
resource "vault_aws_secret_backend" "aws_backend" {
  access_key = var.AWS_access
  secret_key = var.AWS_secret
  region = var.AWS_region
  path = "aws"
}

# Configure a role within the AWS Secret Backend for Vault. In this case this role is hard-coded as "deploy".
# Once configured, reads of "aws/creds/deploy" will contact AWS, create an IAM user with an autogenerated user name: 
#   vault-<vault user generating request>-<vault role used ("deploy" here)-<auto id>-<auto id>
# An Access key / secret access key for this IAM user will be returned in the READ response. That IAM user will
# have the IAM policy coded inline below, subject to restrictions on the "parent" IAM user (see API key above).
resource "vault_aws_secret_backend_role" "role" {
  backend = "${vault_aws_secret_backend.aws_backend.path}"
  name    = "deploy"
  credential_type = "iam_user"

  policy_document = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*"
    }
  ]
}
EOT
}