terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.58.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.43.0, < 2.44.0"
    }
  }
}

provider "azurerm" {
  features {}
}
