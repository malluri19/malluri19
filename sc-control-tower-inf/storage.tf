resource "azurerm_storage_account" "storage-account" {
  name                             = "stscct${var.environment}"
  resource_group_name              = var.resource_group_name
  location                         = var.location
  account_kind                     = var.account_kind
  account_tier                     = var.account_tier
  account_replication_type         = var.storage_account_replication_type
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  enable_https_traffic_only        = var.enable_https_traffic_only
  min_tls_version                  = var.min_tls_version
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  is_hns_enabled                   = var.is_hns_enabled
  access_tier                      = var.access_tier
  tags = merge(local.tags, {})

  network_rules {
    default_action             = var.network_default_action
    bypass                     = var.bypass  
    # https://github.com/krogertechnology/whitelist-helper?ref=v0.1.35
    ip_rules                   = concat(local.ip_whitelist, var.additional_ip_whitelist) 
    virtual_network_subnet_ids = [azurerm_subnet.sub-network.id]
  }

  identity {
    type = var.identity_system_assigned
  }
  
   depends_on = [
    azurerm_subnet.sub-network
  ]
}

resource "azurerm_advanced_threat_protection" "advanced-threat-protection" {
  target_resource_id = azurerm_storage_account.storage-account.id
  enabled            = var.advanced_threat_protection
}