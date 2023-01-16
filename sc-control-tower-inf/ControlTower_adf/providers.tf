terraform {
  required_version = ">= 1.0.0"

 required_providers {
    random = {
      version = ">= 3.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.29.1" # current version is 3.29.1
    }
  }
}

#Provides configuration details for the Azure terraform provider
provider "azurerm" {
  features {}
}
provider azurerm {
  alias   = "CloudOpsSubscription"
  skip_provider_registration = true
  subscription_id            = "2912a3d7-4fae-4252-9f75-670d4c28b63a"
  features {}
}