provider "azurerm" {
  features {}

  skip_provider_registration = true
}

# Depends on the following resources:
# resource "azurerm_resource_provider_registration" "kubernetes" {
#   name = "Microsoft.Kubernetes"
# }
#
# resource "azurerm_resource_provider_registration" "kubernetesconfiguration" {
#   name = "Microsoft.KubernetesConfiguration"
# }
# The reason for not registering them as part of this module is that the tests will fail since 
# the login is done before registering them, thus the access token misses the required permissions.

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.resource_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.location

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  azure_active_directory_role_based_access_control {
    admin_group_object_ids = [var.admin_group_object_id]
  }

  lifecycle {
    ignore_changes = [
      azure_policy_enabled,
      microsoft_defender
    ]
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "calico"
    dns_service_ip    = "10.0.0.10"
    service_cidr      = "10.0.0.0/16"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_kubernetes_cluster_extension" "flux" {
  name           = "flux"
  cluster_id     = azurerm_kubernetes_cluster.aks.id
  extension_type = "microsoft.flux"
}
