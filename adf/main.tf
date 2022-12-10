data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name = format("rg-%s-%s-%s", var.location, var.environment, var.project)

  location = var.location
}

