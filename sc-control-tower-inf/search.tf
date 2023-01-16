resource "azurerm_search_service" "search-service" {
  name                = "srch-sc-ct-${var.environment}-${var.location_abbr}"
  location            = var.location
  resource_group_name = var.resource_group_name 
  sku                 = var.sku_search_service
  tags = merge(local.tags, {})
}