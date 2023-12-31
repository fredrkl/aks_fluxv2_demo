provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "name" {
  name                     = "name"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  location                 = var.resource_group.location
  resource_group_name      = var.resource_group.name
  min_tls_version          = "TLS1_2"
}
