resource "azurerm_role_assignment" "rbac-web" {
  scope                = azurerm_storage_account.storage-account.id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_linux_web_app.web-app.identity[0].principal_id

   depends_on = [
    azurerm_storage_account.storage-account,
    azurerm_linux_web_app.web-app
  ]
}

resource "azurerm_role_assignment" "rbac-func" {
  scope                = azurerm_storage_account.storage-account.id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_linux_function_app.func-app.identity[0].principal_id

   depends_on = [
    azurerm_storage_account.storage-account,
    azurerm_linux_function_app.func-app
  ]
}