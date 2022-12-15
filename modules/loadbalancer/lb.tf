resource "azurerm_lb" "standard_lb" {
  name                = var.lbname
  location            = var.location
  resource_group_name = var.rgname
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                          = "lbfrontend"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}