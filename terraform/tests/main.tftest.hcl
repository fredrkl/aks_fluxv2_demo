provider "azurerm" {
  features {
#    resource_group {
#      prevent_deletion_if_contains_resources = false
#    }
  }
}

run "setup_tests"{
  command = apply

  module {
    source = "./tests/setup"
  }
}

run "valid_storage_account" {
  command = apply

  module {
    source  = "./modules/storageaccount"
  }

  variables {
    resource_group_name  = run.setup_tests.resource_group_name
    storage_account_name = run.setup_tests.storage_account_name
  }

  assert {
    condition     = azurerm_storage_account.storage.name == run.setup_tests.storage_account_name
    error_message = "Storage account not created"
  }
}
