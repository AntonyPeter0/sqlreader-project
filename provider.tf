terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.65.0"
    }
  }

  cloud {
    organization = "infinite_inc"

    workspaces {
      name = "sqlreader-project"
    }
  }
}


provider "azurerm" {
  # Configuration options
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  client_id = var.client_id
  client_secret = var.client_secret

  features {}
}