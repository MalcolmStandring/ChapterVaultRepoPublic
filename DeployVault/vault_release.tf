data "helm_repository" "banzaicloud-stable" {
  name = "banzaicloud-stable"
  url  = "https://kubernetes-charts.banzaicloud.com"
}
resource "helm_release" "vault-operator" {
  name       = "vault-operator"
  repository = data.helm_repository.banzaicloud-stable.metadata[0].url
  chart      = "vault-operator"
 
  set {
      name = "image.tag"
      value = "0.4.17"
  }
  set {
      name = "etcd-operator.enabled"
      value = false
  }
}