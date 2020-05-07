resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }
}

resource "helm_release" "vault" {
  depends_on = [helm_release.etcd]

  name      = "vault"
  chart     = "vault-helm"
  namespace = kubernetes_namespace.vault.metadata.0.name

  values = [
    templatefile("vault.tmpl", { replicas = var.initial_node_count })
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

  data = {
    "tls_crt" = file("certs/tls.crt"),
    "tls_key" = file("certs/tls.key")
  }
}