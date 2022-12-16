resource "azurerm_mssql_server" "dbserver" {
  name                         = var.dbsname
  resource_group_name          = var.rgname
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_server_transparent_data_encryption" "dbserver" {
  server_id = azurerm_mssql_server.dbserver.id
}

resource "azurerm_mssql_database" "database" {
  name                = var.dbname
  server_id           = azurerm_mssql_server.dbserver.id
  collation           = var.collation
  //license_type        = "LicenseIncluded"
  read_replica_count  = 0
  max_size_gb         = 250
  read_scale          = false
  sku_name            = var.sku_name
  zone_redundant      = false

  short_term_retention_policy {
    retention_days = 7
  }
  threat_detection_policy {
    disabled_alerts            = []
    email_account_admins       = "Enabled"
    email_addresses            = []
  }
}

