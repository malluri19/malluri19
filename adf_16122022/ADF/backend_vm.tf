module "linux_vm" {
    source              = "../modules/linux_vm"
    rgname              = data.azurerm_resource_group.rgname.name
    location            = var.location
    vmname              = var.vmname
    nicname             = format( "%s-nic", var.vmname)
    subnet_id           = data.azurerm_subnet.besubnetid.id
}