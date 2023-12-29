provider "azurerm" {
  features {}
}

variables {
  resource_group_name = "flux-unit-test"
}

run "valid_resource_group" {
  command = apply

  assert {
    condition     = azurerm_resource_group.resouce_group.name == "flux-unit-test"
    error_message = "Resource group not created"
  }
}
