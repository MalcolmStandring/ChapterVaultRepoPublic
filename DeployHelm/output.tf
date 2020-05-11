output "vault_address" {
  value = "https://${data.kubernetes_service.vault_svc.spec.0.cluster_ip}:${data.kubernetes_service.vault_svc.spec.0.port.0.port}"
}

output "etcd_address" {
  value = "http://${data.kubernetes_service.etcd_svc.spec.0.cluster_ip}:${data.kubernetes_service.etcd_svc.spec.0.port.0.port}"
}
