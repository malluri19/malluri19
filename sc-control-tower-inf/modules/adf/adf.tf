resource "azurerm_data_factory" "adf" {
  name                = var.adfname
  location            = var.location
  resource_group_name = var.rgname
  managed_virtual_network_enabled = true
  public_network_enabled          = false
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_data_factory_managed_private_endpoint" "myadf_pep" {
  name               = var.dfpep
  data_factory_id    = azurerm_data_factory.adf.id
  target_resource_id = var.target_resource_id
  subresource_name   = var.subresource_name
}

resource "azurerm_data_factory_linked_service_sql_server" "my_sql1" {
  name              = var.dfsqllinkname
  # resource_group_name = var.rgname
  data_factory_id   = azurerm_data_factory.adf.id
  connection_string = var.connection_string
}
resource "azurerm_data_factory_dataset_sql_server_table" "sql_table" {
  name                = var.dfsqltablename
  # resource_group_name = var.rgname
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_sql_server.my_sql1.name
}

resource "azurerm_data_factory_managed_private_endpoint" "adf-msssql-pe" {
  name               = var.adfmssqlpe
  data_factory_id    = azurerm_data_factory.adf.id
  target_resource_id = azurerm_mssql_server.dbserver.id
  subresource_name   = "sqlServer"
}

resource "azurerm_data_factory_linked_service_azure_sql_database" "linked_service_azure_sql_database" {
  name                     = var.adfmssqlpe
  # resource_group_name      = var.rgname
  data_factory_id          = azurerm_data_factory.adf.id
  # description              = try(var.description, null)
  integration_runtime_name = var.adfintrunname
  connection_string    = "integrated security=False;encrypt=True;connection timeout=30;data source=${azurerm_mssql_server.dbserver.fully_qualified_domain_name};initial catalog=${azurerm_mssql_database.database.name}"
}

resource "azurerm_data_factory_integration_runtime_azure" "adf" {
  name                    = var.adfintrunname
  data_factory_id         = azurerm_data_factory.adf.id
  # resource_group_name     = var.rgname
  location                = var.location
  virtual_network_enabled = true
}