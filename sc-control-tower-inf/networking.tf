resource "azurerm_virtual_network" "virtual-network" {
  name                  = "vnet-sc-ct-${var.environment}-${var.location_abbr}"
  address_space         = var.virtual-network_address
  resource_group_name   = var.resource_group_name
  location              = var.location 
  tags = merge(local.tags, {})
}

resource "azurerm_subnet" "sub-network" {
  name                 = "snet-sc-ct-${var.environment}-${var.location_abbr}"
  resource_group_name  = var.resource_group_name 
  virtual_network_name = azurerm_virtual_network.virtual-network.name
  address_prefixes     = var.subnet_address
  service_endpoints    = var.service_endpoints
  
   depends_on = [
    azurerm_virtual_network.virtual-network
  ]
}