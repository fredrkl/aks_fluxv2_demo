provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "vnet" {
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet_second" {
  address_space       = ["10.1.0.0/16"]
  location            = "eastus"
  name                = var.vnet_name_second
  resource_group_name = var.resource_group_name
}
