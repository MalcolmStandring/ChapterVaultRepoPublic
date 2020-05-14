resource "vault_mount" "kv2_secrets_engine" {
  path        = "kv"
  type        = "kv-v2"
  description = "kv2 secrets engine for Key:Vlue secrets"
}