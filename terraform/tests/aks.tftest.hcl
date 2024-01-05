provider "azurerm" {
  features {}
}

run "setup_tests"{
  command = apply

  module {
    source = "./tests/setup"
  }
}

run "valid_vnet_another" {
  command = apply

  module {
    source = "./modules/vnet"
  }

  variables {
    vnet_name           = run.setup_tests.vnet_name
    vnet_name_second    = run.setup_tests.vnet_name_second
    resource_group_name = run.setup_tests.resource_group.name
  }

  assert {
    condition     = azurerm_virtual_network.vnet.name == run.setup_tests.vnet_name
    error_message = "Wrong vnet name"
  }

  assert {
    condition     = azurerm_virtual_network.vnet_second.name == run.setup_tests.vnet_name_second
    error_message = "Wrong second vnet name"
  }
}

#run "aks-creation_valid-input_cluster-created " {
#  command = apply
#
#  module {
#    source = "./modules/aks"
#  }
#
#  variables {
#    resource_group_name = run.setup_tests.resource_group.name
#    cluster_name        = run.setup_tests.cluster_name
#    location            = run.setup_tests.location
#    node_count          = 1
#    node_vm_size        = "Standard_D2_v2"
#    kubernetes_version  = "1.18.14"
#    tags                = {
#      Environment = "unit-test"
#    }
#  }
#
#  assert {
#    condition     = azurerm_kubernetes_cluster.aks.name == run.setup_tests.cluster_name
#    error_message = "AKS cluster not created"
#  }
#}
