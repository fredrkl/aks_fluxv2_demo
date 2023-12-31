provider "azurerm" {
  features {}
}

variables {
  resource_group_name = "flux-unit-test"
}

#run "valid_resource_group" {
#  command = apply
#
#  assert {
#    condition     = azurerm_resource_group.resource_group.name == "flux-unit-test"
#    error_message = "Resource group not created"
#  }
#}

run "setup_tests"{
  module {
    source = "./tests/setup"
  }
}

#run "valid_srorage_account" {
#  command = apply
#
#  module {
#    source = "./modules/storage_account"
#
#    resource_group = var.resource_group_name
#  }
#
#  assert {
#    condition     = azurerm_storage_account.storage_account.name == "name"
#    error_message = "Storage account not created"
#  }
#}
