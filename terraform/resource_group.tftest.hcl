provider "azurerm" {
  features {}
}

run "valid_resource_group" {
  command = apply

  assert {
    condition     = azurerm_resource_group.resouce_group.id != null
    error_message = "Resource group not created"
  }
}
