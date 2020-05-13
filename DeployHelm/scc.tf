# Defines and applies SCC's (Security Context Constraints) to allow helm charts to deploy pods requiring capabilities denied by default
# Since the Terraform "kubernetes" provider is itself not cognisant of SCC's, only K8-native PSP's (Pod Security Policies), we treat
# SCC's as a "special" kind of PSP (that can be applied in OpenShift directly to a user/service account), and stage through a cluster role
# and cluster role binding to the service accounts concerned.
# The two SCC's required are:
#   1. Etcd -  "hostmount-anyuid" SCC applied to system.serviceaccount:etcd:default
#   2. Vault - "privileged" SCC       applied to system.serviceaccount:vault:vault
resource "kubernetes_cluster_role" "scc_role_hostmount_anyuid" {
    metadata {
        name = "psp-hostmount-anyuid"
    }

    rule {
        api_groups = [ "security.openshift.io" ]
        resources  = [ "securitycontextconstraints" ]
        resource_names  = ["hostmount-anyuid"]
        verbs      = [ "use" ]
    }
}

resource "kubernetes_cluster_role_binding" "etcd_scc_role_hostmount_anyuid" {
    depends_on = [ kubernetes_cluster_role.scc_role_hostmount_anyuid ]

    metadata {
        name = "psp-sa-etcd-default"
    }

    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind      = "ClusterRole"
        name      = "psp-hostmount-anyuid"
    }

    subject {
        kind = "User"
        name = "system:serviceaccount:etcd:default"
        api_group = "rbac.authorization.k8s.io"
    }
}

resource "kubernetes_cluster_role" "scc_role_privileged" {
    metadata {
        name = "psp-privileged"
    }

    rule {
        api_groups = [ "security.openshift.io" ]
        resources  = [ "securitycontextconstraints" ]
        resource_names  = ["privileged"]
        verbs      = [ "use" ]
    }
}

resource "kubernetes_cluster_role_binding" "vault_scc_role_privileged" {
    depends_on = [ 
        kubernetes_cluster_role.scc_role_privileged 
        ]

    metadata {
        name = "psp-sa-vault-vault"
    }

    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind      = "ClusterRole"
        name      = "psp-privileged"
    }

    subject {
        kind = "User"
        name = "system:serviceaccount:vault:vault"
        api_group = "rbac.authorization.k8s.io"
    }
}

