provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = random_pet.rg.id
  location = "eastus"
}

resource "random_pet" "rg" {
  length = 1
}

resource "random_string" "storage_account_name" {
  length  = 8
  special = false
}

output "storage_account_name" {
  value = random_string.storage_account_name.result
}

output "resource_group" {
  value = azurerm_resource_group.resource_group
}

terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.85.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
