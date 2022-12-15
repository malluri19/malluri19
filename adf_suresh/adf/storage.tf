module "storage_account" {
    source                   = "../modules/storage"
    storagename              = format("%s%s%s%sstg", var.prefix, var.location, var.environment, var.project)
    rgname                   = data.azurerm_resource_group.rgname.name
    location                 = data.azurerm_resource_group.rgname.location
    account_tier             = var.account_tier
    account_replication_type = var.account_replication_type
}