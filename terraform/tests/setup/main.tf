provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = random_pet.rg.id
  location = "eastus"
}


resource "random_pet" "rg" {
  length = 4
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
