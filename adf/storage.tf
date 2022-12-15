# module "storage_account" {
#     source                   = "../modules/storage"
#     storagename              = var.regions[count.index].storage.storageaccount.storage_name
#     rgname                   = var.regions[count.index].storage.storageaccount.rgname
#     location                 = var.regions[count.index].region
#     account_tier             = var.regions[count.index].storage.storageaccount.account_tier
#     account_replication_type = var.regions[count.index].storage.storageaccount.replication_type
#     tags                     = var.regions[count.index].tags
# }