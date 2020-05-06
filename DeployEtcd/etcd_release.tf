data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}
resource "helm_release" "etcd-operator" {
  name       = "etcd-operator"
  repository = data.helm_repository.stable.metadata[0].url
  chart      = "etcd-operator"
  # version    = "3.4.0"

  values = [
    "${file("etcd_operator_values.yaml")}"
  ]
}
