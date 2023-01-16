resource "azurerm_service_plan" "app-service-plan" {
  name                = "asp-sc-ct-${var.environment}-${var.location_abbr}"
  resource_group_name = var.resource_group_name 
  location            = var.location 
  os_type             = var.os_type
  sku_name            = var.sku_service_plan
  tags = merge(local.tags, {})
}

resource "azurerm_linux_web_app" "web-app" {
  name                = "app-sc-ct-${var.environment}-${var.location_abbr}"
  resource_group_name = var.resource_group_name 
  location            = azurerm_service_plan.app-service-plan.location
  service_plan_id     = azurerm_service_plan.app-service-plan.id
  tags = merge(local.tags, {})

  site_config {
    minimum_tls_version = 1.2
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.application-insights.instrumentation_key}"
  }

  identity {
    type = var.identity_system_assigned
  }

   depends_on = [
    azurerm_service_plan.app-service-plan,
    azurerm_application_insights.application-insights
  ]
}

resource "azurerm_linux_function_app" "func-app" {
  name                        = "func-sc-ct-${var.environment}-${var.location_abbr}"
  resource_group_name         = var.resource_group_name 
  location                    = var.location 

  storage_account_name        = azurerm_storage_account.storage-account.name
  storage_account_access_key  = azurerm_storage_account.storage-account.primary_access_key
  service_plan_id             = azurerm_service_plan.app-service-plan.id
  functions_extension_version = var.functions_extension_version
  tags = merge(local.tags, {})

  site_config {
    always_on = false
    minimum_tls_version = 1.2
    application_insights_connection_string = "${azurerm_application_insights.application-insights.connection_string}"
    application_stack {
      node_version = 16
    }
  }

  identity {
    type = var.identity_system_assigned
  }
  
   depends_on = [
    azurerm_storage_account.storage-account,
    azurerm_service_plan.app-service-plan,
    azurerm_application_insights.application-insights
  ]
}