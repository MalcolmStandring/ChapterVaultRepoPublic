# Stands up the actual Etcd cluster nodes using the Operator
resource "kubernetes" "EtcdCluster" {
    metadata {
        name = "etcd-cluster-vault"
        labels = {
            App = "Etcd"
        }
    }
    spec {
        size = 1
    }
}