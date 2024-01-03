provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

run "setup_tests"{
  command = apply

  module {
    source = "./tests/setup"
  }
}

run "valid_storage_account" {
  command = apply

  module {
    source  = "./modules/storageaccount"
  }

  variables {
    resource_group_name  = run.setup_tests.resource_group.name
    storage_account_name = run.setup_tests.storage_account_name
  }

  assert {
    condition     = azurerm_storage_account.storage.name == run.setup_tests.storage_account_name
    error_message = "Storage account not created"
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
#  }
#
#  assert {
#    condition     = azurerm_kubernetes_cluster.aks.name == run.setup_tests.cluster_name
#    error_message = "AKS cluster not created"
#  }
#}
