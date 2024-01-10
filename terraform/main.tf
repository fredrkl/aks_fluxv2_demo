provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = "northeurope"
}

module "aks" {
  source                = "./modules/aks"
  resource_group_name   = azurerm_resource_group.resource_group.name
  location              = azurerm_resource_group.resource_group.location
  admin_group_object_id = "caaf54e9-1e67-4cd6-9063-b8a3c8ace3a2"

  count = 1
}

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
