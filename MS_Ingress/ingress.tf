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

# Use a helm-chart to deploy an Ingress Controller
resource "helm_release" "nginx_ingress_controller" {
 depends_on = [kubernetes_namespace.nginx-ingress ]
  name      = "nginx-ingress-controller"
  chart     = "nginx-ingress"
  repository = data.helm_repository.bitnanginx-stablemi.metadata[0].url
  namespace = kubernetes_namespace.nginx-ingress.metadata.0.name
  # Doc: https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-helm/ v1.7.0

  values = [
    templatefile("ingress.tmpl", { })
  ]
}

# Having created a tls.secret for Vault encrypted comms, and an Ingress Controller, now create an ingress
resource "kubernetes_ingress" "vault_ingress" {
    metadata {
        name = "vault"
        namespace = kubernetes_namespace.nginx-ingress.metadata.0.name
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