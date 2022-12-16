# The main resource group for this deployment
resource "azurerm_resource_group" "resourcegroup" {
  name     = var.rgname
  location = var.location
}