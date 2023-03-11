resource "azurerm_databricks_workspace" "databricks1" {
  name = format("dbs-%s-%s-%s-%s",
  local.naming.location[var.location], var.environment, var.bk_name1, var.project)

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = var.databricks_sku
  managed_resource_group_name = format("databricks-%s-%s-%s-%s-managedgroup",
  local.naming.location[var.location], var.environment, var.bk_name1, var.project)
  custom_parameters {
    virtual_network_id  = azurerm_virtual_network.vNetbk1.id
    public_subnet_name  = azurerm_subnet.public1.name
    private_subnet_name = azurerm_subnet.private1.name
    public_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.public1.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private1.id
  }

  depends_on = [
    azurerm_subnet_network_security_group_association.public1,
    azurerm_subnet_network_security_group_association.private1,
  ]
  tags = {
        environment = var.environment
        "Group Name" = "Data and Analytics"
        "Budget Code" = ""
        "Project ID" = ""
        "Deployed By" = ""
        "SL" = "1 High Priority"
        "Privacy Level" = "1 Confidential"
        "Internal Owner" = ""
        "Support Contact" = ""
  }
}