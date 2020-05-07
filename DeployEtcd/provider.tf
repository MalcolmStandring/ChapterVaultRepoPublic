# This provider file assumes we will connect to a local Kubernetes cluster,
# pointed to by "kubectl", so no need to specify connection information.
# This may be a local instance of minikube, running under Hyper-V.
provider "kubernetes" {}
