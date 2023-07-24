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
  subscription_id = "5e8879fd-39b8-4d8a-a218-a9c1079eaccf"
  tenant_id = "bca8edbf-896b-4669-beb6-33d191026036"
  client_id = "b7ca32d8-9ad1-4dcf-aa47-06d47e6ae9b9"
  client_secret = "Kpc8Q~6AxNfWC6bkJ_rnk_wqDiOH5uSp_4HZldr5"

  features {}
}