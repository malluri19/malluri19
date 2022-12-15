data "azurerm_resource_group" "rgname" {
    name = format("%s-%s-%s-%s-rg", var.prefix, var.location, var.environment, var.project)
    depends_on = [
      module.resourcegroup
    ]
}

data "azurerm_subnet" "besubnetid" {
    name = "be-subnet"
    resource_group_name = format("%s-%s-%s-%s-rg", var.prefix, var.location, var.environment, var.project)
    virtual_network_name = format("%s-%s-%s-%s-vnet1", var.prefix, var.location, var.environment, var.project)
    depends_on = [
      module.besubnet
    ]
}
data "azurerm_subnet" "fesubnetid" {
    name = "fe-subnet"
    resource_group_name = data.azurerm_resource_group.rgname.name
    virtual_network_name = format("%s-%s-%s-%s-vnet1", var.prefix, var.location, var.environment, var.project)
    depends_on = [
      module.fesubnet
    ]
}
data "azurerm_subnet" "plssubnetid" {
    name = "pls-subnet"
    resource_group_name = data.azurerm_resource_group.rgname.name
    virtual_network_name = format("%s-%s-%s-%s-vnet1", var.prefix, var.location, var.environment, var.project)
    depends_on = [
      module.besubnet,
      module.virtualnetwork
    ]
}

data "azurerm_lb" "lb" {
    name = var.lbname
    resource_group_name = format("%s-%s-%s-%s-rg", var.prefix, var.location, var.environment, var.project) 
    depends_on = [
      module.loadbalancer
    ]
}