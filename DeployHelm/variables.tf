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

# Etcd "root" account password - for production use, must be specified in a more secure fashion
variable "Etcd_rootpassword" {
    default = "M4ngl3dM4sh"
}

# Namespace for Vault to be stood up in
variable "Vault_namespace" {
    default = "vault"
}

# Count of how many Vault nodes to stand up
variable "Vault_nodecount" {
    default = 1
}