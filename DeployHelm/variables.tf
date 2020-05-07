##################################################################################
# VARIABLES
##################################################################################


#Count of how many Etcd nodes to stand up
variable "Etcd_nodecount" { 
    default = 1 
}

# Count of how many Vault nodes to stand up
variable "Vault_nodecount" {
    default = 1
}