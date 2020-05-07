# Google APIs "stable" Helm Chart repo, defined as a data source
data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

# BanzaiCloud "banzaicloud-stable" Helm Chart repo, defined as a data source
data "helm_repository" "banzaicloud-stable" {
  name = "banzaicloud-stable"
  url  = "https://kubernetes-charts.banzaicloud.com"
}
