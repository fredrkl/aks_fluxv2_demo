# If you want to use a spesific `subscription` for this test, add it to the provider configuration
provider "azurerm" {
  features {}
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
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool.name == "default"
    error_message = "Wrong default node pool name"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool.pod_subnet_id == azurerm_virtual_network.pod.id
    error_message = "Wrong pod subnet"
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
}
