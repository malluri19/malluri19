data "azurerm_resource_group" "rgname" {
    name = var.rgname
}
data "azurerm_virtual_network" "vnet" {
    name = var.vnetname
    resource_group_name = "networking-eastus2"
    # depends_on = [
    #   module.virtualnetwork
    # ]
}
data "azurerm_subnet" "subnetid" {
    name = var.subnetname
    resource_group_name = "networking-eastus2"
    virtual_network_name = var.vnetname
    # depends_on = [
    #   module.virtualnetwork
    # ]
}

# data "azurerm_subnet" "besubnetid" {
#     name = var.besubnet
#     resource_group_name = data.azurerm_resource_group.rgname.name
#     virtual_network_name = var.vnetname
#     depends_on = [
#       module.besubnet,
#       module.virtualnetwork
#     ]
# }
# data "azurerm_subnet" "fesubnetid" {
#     name = var.fesubnet
#     resource_group_name = data.azurerm_resource_group.rgname.name
#     virtual_network_name = var.vnetname
#     depends_on = [
#       module.fesubnet
#     ]
# }
# data "azurerm_subnet" "plssubnetid" {
#     name = var.plssubnet
#     resource_group_name = data.azurerm_resource_group.rgname.name
#     virtual_network_name = var.vnetname
#     depends_on = [
#       module.plssubnet,
#       module.virtualnetwork
#     ]
# }

data "azurerm_lb" "lb" {
    name = var.lbname
    resource_group_name = data.azurerm_resource_group.rgname.name
    depends_on = [
      module.loadbalancer
    ]
}
data "azurerm_storage_account" "storage_id"{
  name = var.storagename
  resource_group_name = data.azurerm_resource_group.rgname.name
}

data "azurerm_shared_image_version" "kroger_shared_image" {
  provider        = azurerm.CloudOpsSubscription
  name            = var.vm_kroger_shared_image_version
  image_name      = var.vm_kroger_shared_image_name
  gallery_name    = var.vm_kroger_shared_image_gallery_name
  resource_group_name = var.vm_kroger_shared_image_gallery-resource_group
}