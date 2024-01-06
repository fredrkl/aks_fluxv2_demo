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
    resource_group_name = run.setup_tests.resource_group.name
    location            = run.setup_tests.resource_group.location
  }

  module {
    source = "./modules/aks"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.name == run.setup_tests.resource_group_name
    error_message = "Wrong aks name"
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
