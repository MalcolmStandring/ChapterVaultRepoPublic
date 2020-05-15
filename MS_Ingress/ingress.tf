provider "tls" {}

resource "tls_private_key" "PK_TLSingress_vault" {
    algorithm = "RSA"
    rsa_bits = 2048
}

resource "tls_self_signed_cert" "CERT_TLSingress_vault" {
    key_algorithm   = tls_private_key.PK_TLSingress_vault.algorithm
    private_key_pem = tls_private_key.PK_TLSingress_vault.private_key_pem
    
    # Certificate expires after 12 hours.
    validity_period_hours = 12

    # Generate a new certificate if Terraform is run within three
    # hours of the certificate's expiration time.
    early_renewal_hours = 3

    # Reasonable set of uses for a server SSL certificate.
    allowed_uses = [
        "key_encipherment",
        "digital_signature",
        "server_auth"
    ]

    dns_names = [ "vault-vault.apps.cluster-1558.sandbox1776.opentlc.com" ]

    subject {
        common_name  = "example.com"
        organization = "Gemini PE Chapter, Capgemini"
    }

}

# Create a vault namespace tls secret with the cert and private key
resource "kubernetes_secret" "SECRET_TLSingress_vault" {
    metadata {
        name = "tls-vault-ingress"
        namespace = "vault"
    }
    data = {
        "tls.crt" = tls_self_signed_cert.CERT_TLSingress_vault.cert_pem
        "tls.key" = tls_private_key.PK_TLSingress_vault.private_key_pem
        }
    type = "kubernetes.io/tls"
}
# At this point we've created a tls.secret token for vault to be exposed.
# Now, we need an Ingress and an Ingress Controller to action it.
# OpenShift has once-step "Routes", but the Kubernetes way requires us
# to install an Ingress Controller first, then give it an Ingress specification.

resource "kubernetes_namespace" "nginx-ingress-controller" {
  metadata {
    name = var.NGINX_namespace
  }
}

# Use a helm-chart to deploy an Ingress Controller.
# The current v1.7.0 is a release candidate and relies on featires in K8 v 1.15+,
# so forced to earlier version. This version fails to auto-crete the required 
# service account, so create that first
resource "kubernetes_secret" "nginx-ingress-controller-nginx-ingress-secret" {
  metadata {
    name = "nginx-ingress-controller-nginx-ingress-secret"
    namespace = kubernetes_namespace.nginx-ingress-controller.metadata.0.name
  }
}
resource "kubernetes_service_account" "nginx-ingress-controller-nginx-ingress" {
  metadata {
    name = "nginx-ingress-controller-nginx-ingress"
    namespace = kubernetes_namespace.nginx-ingress-controller.metadata.0.name
  }
  secret {
    name = "${kubernetes_secret.nginx-ingress-controller-nginx-ingress-secret.metadata.0.name}"
    namespace = kubernetes_namespace.nginx-ingress-controller.metadata.0.name
  }
}
# And bind a PSP to it
resource "kubernetes_cluster_role" "scc_role_nginx" {
    metadata {
        name = "psp-nginx"
    }

    rule {
        api_groups = [ "security.openshift.io" ]
        resources  = [ "securitycontextconstraints" ]
        resource_names  = ["privileged"]
        verbs      = [ "use" ]
    }
}
######### DONE TO THIS POINT!!!!
resource "kubernetes_cluster_role_binding" "nginx_scc_role_privileged" {
    depends_on = [ 
        kubernetes_cluster_role.scc_role_nginx 
        ]

    metadata {
        name = "psp-sa-nginx-nginx"
    }

    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind      = "ClusterRole"
        name      = "psp-nginx"
    }

    subject {
        kind = "User"
        name = "system:serviceaccount:vault:vault"
        api_group = "rbac.authorization.k8s.io"
    }
}


resource "helm_release" "nginx_ingress_controller" {
 depends_on = [kubernetes_namespace.nginx-ingress-controller ]
  name      = "nginx-ingress-controller"
  chart     = "nginx-ingress"
  version   = "0.4.3"
  repository = data.helm_repository.nginx-stable.metadata[0].url
  namespace = kubernetes_namespace.nginx-ingress-controller.metadata.0.name
  # Doc: https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-helm/ v1.7.0

  values = [
    templatefile("ingress.tmpl", { })
  ]
}

# Having created a tls.secret for Vault encrypted comms, and an Ingress Controller, now create an ingress.
# Switched to helm chart v
resource "kubernetes_ingress" "vault_ingress" {
    metadata {
        name = "vault"
        namespace = kubernetes_namespace.nginx-ingress-controller.metadata.0.name
    }

    spec {
        backend {
            service_name = "vault"
            service_port = 8200
        }
        rule {
            http {
                path {
                    backend {
                        service_name = "vault"
                        service_port = 8200
                    }
                    path = "/"
                }
            }
        }
        tls {
            hosts = [ "vault-vault.apps.cluster-1558.sandbox1776.opentlc.com" ]
            secret_name = "tls-vault-ingress"
        }
    }
}

output "Certificate" {
    value = tls_self_signed_cert.CERT_TLSingress_vault.cert_pem
}
output "Private_Key" {
    value = tls_private_key.PK_TLSingress_vault.private_key_pem
}