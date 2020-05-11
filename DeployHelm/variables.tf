##################################################################################
# VARIABLES
##################################################################################

# Namespace for Etcd to be stood up in
variable "Etcd_namespace" {
    default = "etcd"
}

#Count of how many Etcd nodes to stand up
variable "Etcd_nodecount" { 
    default = 1 
}

# Namespace for Vault to be stood up in
variable "Vault_namespace" {
    default = "vault"
}

# Count of how many Vault nodes to stand up
variable "Vault_nodecount" {
    default = 1
}