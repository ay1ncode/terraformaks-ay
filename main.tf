
resource "azurerm_resource_group" "ay-rg" {
  location = var.location
  name     = var.resource_group_name
}
resource "azurerm_kubernetes_cluster" "ay-cluster" {
  location            = var.location
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.ay-rg.name
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = var.cluster_name

  service_principal {
    client_id     = ""#test
    client_secret = ""
  }

  default_node_pool {
    name    = "system"
    vm_size = "Standard_DS2_v2"
    node_count = var.system_node_count
    enable_auto_scaling = false
    
  }
  
  network_profile {
    network_plugin = "kubenet"
    load_balancer_sku = "standard"
  }
}
resource "azurerm_container_registry" "ay-acr" {
  location            = var.location
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.ay-rg.name
  sku                 = "Standard"
  admin_enabled = false
}

resource "azurerm_role_assignment" "role_acrpull" {
  principal_id = azurerm_kubernetes_cluster.ay-cluster.service_principal[0].client_id
  scope        = azurerm_container_registry.ay-acr.id
  skip_service_principal_aad_check = true
  role_definition_name = "AcrPull"
}
