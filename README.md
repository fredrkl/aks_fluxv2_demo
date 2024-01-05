# AKS Flux v2 add on demo

AKS has a built-in integration with Flux v2. This repo is demoing it.

## Prerequisites

- Fork this repo
- Create a new _Azure Entra Application_ and with _Federated credentials_ assigned to your repo.
- Create the following GH Actions secrets:
  - `azure_client_id`: The _Application (client) ID_ of the _Azure AD Application_.
  - `azure_tenant_id`: The _Directory (tenant) ID_ of the _Azure AD Application_.
  - `azure_subscription_id`: The _Subscription ID_ of the _Azure Subscription_.
- Be sure to give the _Azure Entra Application_ you created permissions to the _Azure Subscription_ you are going to use.
- Create a storage account and update the main.tf backend configuration with the storage account name and container name.
- Be sure to give the _Azure Entra Application_ you created permissions to the _Storage Account_ you are going to use with the _Storage Blob Data Contributor_ role and _Storage Account Key Operator Service Role_ role.

## Pre-commit hooks for terraform files (optional)

> :exclamation: The pre-commit hooks are only running on staged files.

To set up pre-commit hooks for terraform files, run the following commands:

```bash
brew install pre-commit
pre-commit install
```

If you want to uninstall the pre-commit hooks, run the following command:

```bash
pre-commit uninstall
```

## Using Azure Storage Account for Terraform state

The Terraform state is stored in an Azure Storage Account configured in the ./terraform/main.tf file.

## Build status (main branch)

[![Terraform](https://github.com/fredrkl/aks_fluxv2_demo/actions/workflows/terraform.yaml/badge.svg)](https://github.com/fredrkl/aks_fluxv2_demo/actions/workflows/terraform.yaml)
