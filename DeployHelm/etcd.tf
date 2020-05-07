resource "kubernetes_namespace" "etcd" {
  metadata {
    name = "etcd"
  }
}

resource "helm_release" "vauetcdlt" {
  name      = "etcd"
  chart     = "etcd-helm"
  namespace = kubernetes_namespace.etcd.metadata.0.name

  values = [
    templatefile("etcd.tmpl", { replicas = var.Vault_nodecount })
  ]
}

data "kubernetes_service" "etcd_svc" {
  depends_on = [
    helm_release.etcd
  ]

  metadata {
    namespace = "etcd"
    name      = "etcd-ui"
  }
}
