resource "azurerm_virtual_network" "vNet" {
  name = var.vnetname
  location            = var.location
  resource_group_name = var.rgname
  address_space = [var.vnetCidr]
}