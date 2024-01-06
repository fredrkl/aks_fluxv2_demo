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

run "valid_vnet" {
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
