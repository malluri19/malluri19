# module "storage_account" {
#     source                   = "../modules/storage"
#     storagename              = var.storagename
#     rgname                   = data.azurerm_resource_group.rgname.name
#     location                 = data.azurerm_resource_group.rgname.location
#     account_tier             = var.account_tier
#     account_replication_type = var.account_replication_type
# }