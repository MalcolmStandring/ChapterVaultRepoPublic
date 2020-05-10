# See https://hub.helm.sh for definitive meta-listing of repositories of Helm charts and repositories
# Google APIs "stable" Helm Chart repo, defined as a data source
data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}
# Contains v 0.9.4 of "etcd-operator" chart (https://hub.helm.sh/charts/stable/etcd-operator)
# COntains v 0.1.9 of "vault-operator" chart (https://hub.helm.sh/charts/stable/vault-operator)

# BanzaiCloud "banzaicloud-stable" Helm Chart repo, defined as a data source
data "helm_repository" "banzaicloud-stable" {
  name = "banzaicloud-stable"
  url  = "https://kubernetes-charts.banzaicloud.com"
}
# Contains v 3.2.9 of "etcd" chart (https://hub.helm.sh/charts/banzaicloud-stable/etcd)
# Contains v 0.6.1 of "etcd-operator" chart (https://hub.helm.sh/charts/banzaicloud-stable/etcd-operator)
# Contains v 1.2.0 of "vault" chart (https://hub.helm.sh/charts/banzaicloud-stable/vault)
# Contains v 1.2.0 of "vault-operator" chart (https://hub.helm.sh/charts/banzaicloud-stable/vault-operator)

# Bitnami "bitnami" Helm Chart repo, defined as a data source
data "helm_repository" "bitnami" {
  name = "bitnami"
  url  = "https://charts.bitnami.com"
}
# Contains v 3.4.7 of "etcd" chart (https://hub.helm.sh/charts/bitnami/etcd)

# Incubator ""
data "helm_repository" "incubator" {
  name = "incubator"
  url = "https://kubernetes-charts-incubator.storage.googleapis.com"
}
# Contains v1.2.3 of "vault" (chart version 0.23.5) (https://hub.helm.sh/charts/incubator/vault)
