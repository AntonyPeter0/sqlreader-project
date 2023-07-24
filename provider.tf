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
      name = "workspace-dev"
    }
  }
}


provider "azurerm" {
  # Configuration options
  subscription_id = ""
  tenant_id = ""
  client_id = ""
  client_secret = ""

  features {}
}