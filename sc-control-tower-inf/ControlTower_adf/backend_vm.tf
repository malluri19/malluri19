resource "azurerm_network_interface" "nic" {
  name                = var.nicname
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = var.ipconfigname
    subnet_id                     = data.azurerm_subnet.subnetid.id
    private_ip_address_allocation = var.pipaddressallocation
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                        = var.vmname
  resource_group_name         = var.rgname
  location                    = var.location
  size                        = var.vmsize
  network_interface_ids       = [azurerm_network_interface.nic.id]
  admin_username              = var.adminuser
  admin_password              = "abcd!234"
  source_image_id             = data.azurerm_shared_image_version.kroger_shared_image.id
  os_disk {
    caching              = var.osdiskcaching
    storage_account_type = var.osdiskacctype
  }

  admin_ssh_key {
    username   = var.adminuser
    public_key = file(var.vmpublickey)
  }
}