resource "azurerm_log_analytics_workspace" "log-analytics" {
  name                = "log-sc-ct-${var.environment}-${var.location_abbr}"
  location            = var.location
  resource_group_name = var.resource_group_name 
  sku                 = var.sku_log_analytics
  retention_in_days   = var.retention_in_days
  tags = merge(local.tags, {})
}

resource "azurerm_application_insights" "application-insights" {
  name                                  = "ai-sc-ct-${var.environment}-${var.location_abbr}"
  location                              = var.location 
  resource_group_name                   = var.resource_group_name 
  workspace_id                          = azurerm_log_analytics_workspace.log-analytics.id
  application_type                      = var.application_type 
  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.daily_data_cap_notification_disabled
  retention_in_days                     = var.retention_in_days
  sampling_percentage                   = var.sampling_percentage
  disable_ip_masking                    = var.disable_ip_masking
  local_authentication_disabled         = var.local_authentication_disabled
  internet_ingestion_enabled            = var.internet_ingestion_enabled
  internet_query_enabled                = var.internet_query_enabled
  force_customer_storage_for_profiler   = var.force_customer_storage_for_profiler
  tags = merge(local.tags, {})
   
   depends_on = [
    azurerm_log_analytics_workspace.log-analytics
  ]
}