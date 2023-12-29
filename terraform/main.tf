provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = "aks-flux-addon-demo"
  location = "eastus"
}

#   resource "azurerm_storage_account" "storage" {
#     location                 = "eastus"
#     name                     = "examplestorageaccount"
#     account_replication_type = "LRS"
#     resource_group_name      = azurerm_resource_group.example.name
#     account_tier             = "Standard"
#     min_tls_version          = "TLS1_2"
#     lifecycle {
#       precondition {
#         condition     = azurerm_resource_group.example.location == "eastus"
#         error_message = "The selected resource group must be located in the eastus region."
#       }
#   
#       postcondition {
#         condition     = self.id != ""
#         error_message = "The storage account was not created successfully."
#       }
#     }
#   }
#   
#   
#   check "storage_account_name_is_valid" {
#     assert {
#       condition     = substr(azurerm_storage_account.storage.name, 0, 7) == "example"
#       error_message = "The storage account name must be between 3 and 24 characters and contain only lowercase letters and numbers."
#     }
#   
#   }
#   
#   resource "azurerm_storage_account" "invalid" {
#     name                     = "invalidstorageaccount"
#     account_replication_type = "LRS"
#     resource_group_name      = azurerm_resource_group.example.name
#     account_tier             = "Standard"
#     location                 = azurerm_resource_group.example.location
#     min_tls_version          = "TLS1_2"
#   
#     enable_https_traffic_only = true
#   }
#   
#   
terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-state-files"
    storage_account_name = "terraformdemostatefiles"
    container_name       = "aks-fluxv2-demo-tfstate"
    key                  = "terraform.tfstate"
  }
}
