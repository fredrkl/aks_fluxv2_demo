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

#  assert {
#    condition     = azurerm_kubernetes_cluster_extension.flux.name == "flux"
#    error_message = "Wrong extension name"
#  }
  assert {
    condition     = azurerm_kubernetes_cluster.aks.network_profile[0].network_plugin == "azure"
    error_message = "Wrong network plugin"
  }
}
