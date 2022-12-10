resource "azurerm_data_factory" "my_adf" {
  name                = "myadf"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  managed_virtual_network_enabled = true
  public_network_enabled          = false
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_account" "my_storage" {
  name                     = "mystorageaccount001"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_data_factory_managed_private_endpoint" "myadf_pep" {
  name               = "mypadfprivate1"
  data_factory_id    = azurerm_data_factory.my_adf.id
  target_resource_id = azurerm_storage_account.my_storage.id
  subresource_name   = "blob"
}

resource "azurerm_data_factory_linked_service_sql_server" "my_sql1" {
  name              = "mysqllink"
  data_factory_id   = azurerm_data_factory.my_adf.id
  connection_string = "Integrated Security=False;Data Source=test;Initial Catalog=test;User ID=test;Password=test"
}

resource "azurerm_data_factory_dataset_sql_server_table" "example" {
  name                = "example"
  data_factory_id     = azurerm_data_factory.my_adf.id
  linked_service_name = azurerm_data_factory_linked_service_sql_server.my_sql1.name
}

resource "azurerm_data_factory_managed_private_endpoint" "name" {
    name = "myadfprovate2"
    data_factory_id = azurerm_data_factory.my_adf.id
    target_resource_id = azurerm_mssql_database.database.id
  
}
##################################
resource "azurerm_data_factory_managed_private_endpoint" "adf-msssql-pe" {
  name               = "adf"
  data_factory_id    = azurerm_data_factory.process-adf.id
  target_resource_id = azurerm_mssql_server.dbserver.id
  subresource_name   = "sqlServer"
}

resource "azurerm_data_factory_integration_runtime_azure" "adf" {
  name                    = "adf"
  data_factory_id         = azurerm_data_factory.process-adf.id
  location                = module.resourcegroup.resource_group.location
  virtual_network_enabled = true
}