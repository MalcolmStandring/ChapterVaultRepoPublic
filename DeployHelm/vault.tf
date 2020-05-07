# Four repos possible for vault helm chart, according to https://hub.helm.sh/charts?q=etcd :
#   - adwerx: vault v ??? - older, probably deprecated
#   - banzaicloud-stable: vault v 1.2.0  *** INITIALLY SELECTED ***
#   - incubator: vault 1.2.3
#   - banzaicloud-stable vault-operator: 1.2.0
#   - stable: vault-operator v 0.1.9
#   - appscode: vault-operator v 0.3.0
resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }
}

resource "helm_release" "vault" {
  depends_on = [helm_release.etcd]

  name      = "vault"
  chart     = "vault"
  repository = data.helm_repository.banzaicloud-stable.metadata[0].url
  namespace = kubernetes_namespace.vault.metadata.0.name
  # Doc: https://hub.helm.sh/charts/banzaicloud-stable/vault v1.2.0

  values = [
    templatefile("vault.tmpl", { replicas = var.Vault_nodecount, etcd_clusterip = data.kubernetes_service.etcd_svc.spec.cluster_ip })
  ]
}

data "kubernetes_service" "vault_svc" {
  depends_on = [
    helm_release.vault
  ]

  metadata {
    namespace = "vault"
    name      = "vault-ui"
  }
}

resource "kubernetes_secret" "vault_tls" {
  metadata {
    name = "tls"
    namespace = "vault"
  }

  #data = {
  #   "tls_crt" = file("certs/tls.crt"),
  #   "tls_key" = file("certs/tls.key")
  #}
}