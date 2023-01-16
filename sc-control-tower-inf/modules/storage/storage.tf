resource "azurerm_storage_account" "example" {
  name                     = var.storagename
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}