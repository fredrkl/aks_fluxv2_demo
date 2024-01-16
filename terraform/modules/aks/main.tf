#provider "azurerm" {
#  features {}
#
#  skip_provider_registration = true
#}

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

resource "azurerm_virtual_network" "vnet" {
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  name                = "aks-vnet"
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "nodes" {
  name                 = "aks-nodes"
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.0.1.0/27"]
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "pod" {
  name                 = "aks-pod"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.resource_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.location

  default_node_pool {
    name          = "default"
    node_count    = 3
    vm_size       = "Standard_D2_v2"
    pod_subnet_id = azurerm_subnet.pod.id
  }

  network_profile {
    network_plugin  = "azure"
    ebpf_data_plane = "cilium"
    network_policy  = "cilium"
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      azure_policy_enabled,
      microsoft_defender
    ]
  }
}

resource "azurerm_kubernetes_cluster_extension" "flux" {
  name           = "flux"
  cluster_id     = azurerm_kubernetes_cluster.aks.id
  extension_type = "microsoft.flux"
}
