provider "azurerm" {
  features {}
}

run "valid_resource_group" {
  command = create

  assert {
    condition     = azurerm_resource_group.resouce_group.id != null
    error_message = "Resource group not created"
  }
}
