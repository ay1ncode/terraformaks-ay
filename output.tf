output "location-cluster" {
  value = var.location
}

output "node-count-cluster" {
  value = var.system_node_count
}

output "acr-name" {
  value = var.acr_name
}

output "kube-cluster-name" {
  value = var.cluster_name
}

output "aks-resource-name" {
  value = azurerm_kubernetes_cluster.ay-cluster.resource_group_name
}
output "aks_id" {
  value = azurerm_kubernetes_cluster.ay-cluster.id
}
output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.ay-cluster.fqdn
}

output "acr_id" {
  value = azurerm_container_registry.ay-acr.id
}

output "acr_login_server" {
  value = azurerm_container_registry.ay-acr.login_server
}

resource "local_file" "kubeconfig" {
  filename = "kubeconfig"
  content = azurerm_kubernetes_cluster.ay-cluster.kube_config_raw
  depends_on = [azurerm_container_registry.ay-acr]
}
