# The Azure Active Resource Manager Terraform provider
provider "azurerm" {
  version = "=1.36.0"
}

# The Azure Active Directory Terraform provider
provider "azuread" {
  version = "=0.6.0"
}

# Reference to the current subscription.  Used when creating role assignments
data "azurerm_subscription" "current" {}
