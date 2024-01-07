provider "azurerm" {
  features {}
}

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

resource "azurerm_role_assignment" "tf_flux" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service Contributor"
  principal_id         = "a97e1737-c63d-4b47-9d48-983a320329e5" # terraform-demo
}
