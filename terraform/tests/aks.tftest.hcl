# If you want to use a spesific `subscription` for this test, add it to the provider configuration
provider "azurerm" {
#  alias = "Microsoft_Azure_sponsing"
  features {}
#  subsription_id = "d8fc2dcc-fe0e-418a-bf44-7d2512d6d068"
}

run "setup_tests"{
  command = apply

  module {
    source = "./tests/setup"
  }
}

run "aks-creation" {
  command = apply

  variables {
    resource_group_name   = run.setup_tests.resource_group.name
    location              = run.setup_tests.resource_group.location
    admin_group_object_id = "caaf54e9-1e67-4cd6-9063-b8a3c8ace3a2"
  }

  module {
    source = "./modules/aks"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.name == run.setup_tests.resource_group.name
    error_message = "Wrong aks name"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool[0].name == "default"
    error_message = "Wrong default node pool name"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool[0].pod_subnet_id == azurerm_subnet.pod.id
    error_message = "Wrong pod subnet"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool[0].vnet_subnet_id == azurerm_subnet.nodes.id
    error_message = "Missing node subnet"
  }

  assert {
    condition     = azurerm_kubernetes_cluster_extension.flux.name == "flux"
    error_message = "Wrong extension name"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.network_profile[0].network_plugin == "azure"
    error_message = "Wrong network plugin"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.network_profile[0].ebpf_data_plane == "cilium"
    error_message = "Missing ebpf data plane"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.network_profile[0].network_policy == "cilium"
    error_message = "Missing cilium network policy"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.local_account_disabled == true
    error_message = "Local account should be disabled"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.azure_active_directory_role_based_access_control[0].managed == true
    error_message = "Azure AD Integration must be enabled"
  }
}
