resource "azurerm_key_vault" "kv-internal" {
  name                        = "kv-sc-ct-${var.environment}-${var.location_abbr}"
  location                    = var.location
  resource_group_name         = var.resource_group_name 
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  # Because this is enabled, if KV is deleted, it will remain in state and not allow you to re-create it.
  # You cannot reuse the name of a KV that has been soft-deleted until the retention period has passed.
  # By default the retention period is 90 days 
  purge_protection_enabled    = true
  sku_name = "standard"
  tags = merge(local.tags, {})

  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_linux_function_app.func-app.identity[0].principal_id
    secret_permissions = [
      "Get",
      "List",
    ]
  }

  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_linux_web_app.web-app.identity[0].principal_id
    secret_permissions = [
      "Get",
      "List",
    ]
  }

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.terraform_github_sp_object_id
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore"
    ]
  }
  
  depends_on = [
    azurerm_linux_web_app.web-app,
    azurerm_linux_function_app.func-app
  ]
}

resource "azurerm_key_vault_secret" "sa-primary-key" {
  name         = "SA-Primary-Key"
  value        = azurerm_storage_account.storage-account.primary_access_key
  key_vault_id = azurerm_key_vault.kv-internal.id

  depends_on = [
    azurerm_storage_account.storage-account,
    azurerm_key_vault.kv-internal
  ]
}