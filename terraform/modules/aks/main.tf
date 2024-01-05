provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "vnet_aks" {
  name                = "vnet_aks"
  address_space       = ["11.0.0.0/24"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

#resource "azurerm_aks" "aks" {
#  name                = var.cluster_name
#  location            = var.location
#  resource_group_name = var.resource_group_name
#  kubernetes_version  = var.kubernetes_version
#
#  default_node_pool {
#    name       = "default"
#    node_count = var.node_count
#    vm_size    = var.node_vm_size
#  }
#
#  lifecycle {
#    ignore_changes = [
#      azure_policy_enabled,
#      microsoft_defender
#    ]
#  }
#
#  network_profile {
#    network_plugin    = "azure"
#    network_policy    = "calico"
#    dns_service_ip    = "10.0.0.10"
#    service_cidr      = "10.0.0.0/16"
#    load_balancer_sku = "standard"
#  }
#
#  identity {
#    type = "SystemAssigned"
#  }
#
#  tags = var.tags
#}
