# Four repos possible for etcd helm chart, according to https://hub.helm.sh/charts?q=etcd :
#   - banzaicloud-stable: etcd v 3.2.9
#   - incubator: etcd v 3.2.26
#   - bitnami: 3.4.7    *** INITIALLY SELECTED ***
#   - banzaicloud-stable: etcd-operator v 0.6.1
resource "kubernetes_namespace" "etcd" {
  metadata {
    name = var.Etcd_namespace
  }
}

resource "helm_release" "etcd" {
 depends_on = [kubernetes_namespace.etcd, kubernetes_cluster_role_binding.etcd_scc_role_hostmount_anyuid ]
  name      = "etcd"
  chart     = "etcd"
  repository = data.helm_repository.bitnami.metadata[0].url
  namespace = kubernetes_namespace.etcd.metadata.0.name
  # Doc: https://hub.helm.sh/charts/bitnami/etcd v3.4.7

  values = [
    templatefile("etcd.tmpl", { 
      replicas = var.Etcd_nodecount,
      rootpwd = var.Etcd_rootpassword })
  ]
}

data "kubernetes_service" "etcd_svc" {
  depends_on = [
    helm_release.etcd
  ]
  metadata {
    namespace = "etcd"
    name      = "etcd"
  }
}
