# ChapterVaultRepo
## Synopsis
A component of **Genesis** Platform Engineering cohort's **Landing Zone** project.
## Sub-folders
1. `DeployHelm` - A **non-controller** based approach for Terraform deployment of Etcd storage backend and Vault HA configs using Helm and YAML scripts. 
   "**variables.tf**" allows for configuration of nampespaces, number of HA nodes etc.
1. `ConfigureVault` - Configuration of Vault post-deployment. HCL policies, AWS KMS.
