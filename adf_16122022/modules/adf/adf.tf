resource "azurerm_data_factory" "my_adf" {
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
  name               = var.dfped
  data_factory_id    = azurerm_data_factory.my_adf.id
  target_resource_id = var.target_resource_id
  subresource_name   = var.subresource_name
}

resource "azurerm_data_factory_linked_service_sql_server" "my_sql1" {
  name              = var.dfsqllinkname
  resource_group_name = var.rgname
  data_factory_id   = azurerm_data_factory.my_adf.id
  connection_string = var.connection_string
}
resource "azurerm_data_factory_dataset_sql_server_table" "sql_table" {
  name                = var.dfsqltablename
  resource_group_name = var.rgname
  data_factory_id     = azurerm_data_factory.my_adf.id
  linked_service_name = azurerm_data_factory_linked_service_sql_server.my_sql1.name
}
resource "azurerm_data_factory_managed_private_endpoint" "name" {
    name = var.adfprivatendpoint2
    data_factory_id = azurerm_data_factory.my_adf.id
    target_resource_id = azurerm_mssql_database.database.id
  
}

resource "azurerm_data_factory_managed_private_endpoint" "adf-msssql-pe" {
  name               = var.adfmssqlpe
  data_factory_id    = azurerm_data_factory.my_adf.id
  target_resource_id = azurerm_mssql_server.dbserver.id
  subresource_name   = "sqlServer"
}

resource "azurerm_data_factory_linked_service_azure_sql_database" "linked_service_azure_sql_database" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  data_factory_name        = var.data_factory_name
  description              = try(var.description, null)
  integration_runtime_name = try(var.integration_runtime_name, null)
}
resource "azurerm_data_factory_integration_runtime_azure" "adf" {
  name                    = var.adfintrunname
  data_factory_id         = azurerm_data_factory.my_adf.id
  resource_group_name     = var.rgname
  location                = var.location
  virtual_network_enabled = true
}
