provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "name" {
  name                     = var.storage_account_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  location                 = "eastus"
  resource_group_name      = var.resource_group_name
  min_tls_version          = "TLS1_2"
}
