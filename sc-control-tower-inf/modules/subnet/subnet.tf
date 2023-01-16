resource "azurerm_subnet" "subnet" {
  name = var.subnetname
  resource_group_name  = var.rgname
  virtual_network_name = var.vnetname
  address_prefixes     = [var.SubnetCidr]
  # enforce_private_link_endpoint_network_policies = true
}