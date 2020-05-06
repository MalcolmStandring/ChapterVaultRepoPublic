data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}
resource "helm_release" "etcd_operator" {
  name       = "etcd_operator"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "etcd-operator"
  version    = "0.9.4"

  values = [
    "${file("etcd_operator_values.yaml")}"
  ]
}
