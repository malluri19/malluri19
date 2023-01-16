# define the required providers and their versions here
# define the attributes for the provider when instantiating it in providers.tf
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

provider "azurerm" {
  features {
    #  key_vault {
    #   purge_soft_delete_on_destroy = false
    # }
  }
}