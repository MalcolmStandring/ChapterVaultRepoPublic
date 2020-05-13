# This provider file assumes we will connect to a local Kubernetes cluster,
# pointed to by "kubectl", so no need to specify connection information.
# This may be a local instance of minikube, running under Hyper-V.
# https://www.terraform.io/docs/providers/kubernetes/index.html
provider "kubernetes" {}

# The Helm Chart provider, consisting of: 
#   - "helm_repository" data sources, and 
#   - "helm_release" resources (being an instantiation/installation of a particular Helm Chart)
# https://www.terraform.io/docs/providers/helm/index.html
# Note: requires installation of "Helm" plugin to Terraform: 
# https://github.com/terraform-providers/terraform-provider-helm
provider "helm" {
    kubernetes {

    }
}

