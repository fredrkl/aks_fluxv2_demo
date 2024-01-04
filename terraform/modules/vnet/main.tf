provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "vnet" {
  address_space       = ["10.0.0.1/16"]
  location            = "eastus"
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}
