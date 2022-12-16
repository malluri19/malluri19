module "virtualnetwork" {
    source              = "../modules/virtual_network"
    rgname            = data.azurerm_resource_group.rgname.name
    location            = var.location
    vnetname            = format("%s-%s-%s-%s-vnet1", var.prefix, var.location, var.environment, var.project)
    vnetCidr            = var.vnetCidr
}
module "besubnet" {
    source              = "../modules/subnet"
    rgname            = data.azurerm_resource_group.rgname.name
    location            = var.location
    subnetname          = "be-subnet"
    vnetname            = format("%s-%s-%s-%s-vnet1", var.prefix, var.location, var.environment, var.project)
    SubnetCidr          = var.beSubnetCidr
}
module "fesubnet" {
    source              = "../modules/subnet"
    rgname            = data.azurerm_resource_group.rgname.name
    location            = var.location
    subnetname          = "fe-subnet"
    vnetname            = format("%s-%s-%s-%s-vnet1", var.prefix, var.location, var.environment, var.project)
    SubnetCidr          = var.feSubnetCidr
}
module "plssubnet" {
    source              = "../modules/subnet"
    rgname            = data.azurerm_resource_group.rgname.name
    location            = var.location
    subnetname          = "pls-subnet"
    vnetname            = format("%s-%s-%s-%s-vnet1", var.prefix, var.location, var.environment, var.project)
    SubnetCidr          = var.plsSubnetCidr
}

module "loadbalancer" {
    source              = "../modules/loadbalancer"
    rgname            = data.azurerm_resource_group.rgname.name
    location            = var.location
    lbname              = var.lbname
    lb_sku              = var.lb_sku
    subnet_id           = data.azurerm_subnet.fesubnetid.id
}
# #Create Backend Address Pool
resource "azurerm_lb_backend_address_pool" "business-backend-pool" {
  loadbalancer_id = data.azurerm_lb.lb.id
  name            = "business-backend-pool"
}

#Create Probe
resource "azurerm_lb_probe" "ssh-inbound-probe" {
  loadbalancer_id     = data.azurerm_lb.lb.id
  name                = "ssh-inbound-probe"
  port                = 22
  resource_group_name = format("%s-%s-%s-%s-rg", var.prefix, var.location, var.environment, var.project)
}

#Create Loadbalancing Rules
resource "azurerm_lb_rule" "inbound-rules" {
  loadbalancer_id                = data.azurerm_lb.lb.id
  name                           = "ssh-inbound-rule"
  resource_group_name = format("%s-%s-%s-%s-rg", var.prefix, var.location, var.environment, var.project)
  protocol                       = "Tcp"
  frontend_port                  = 1433
  backend_port                   = 1433
  frontend_ip_configuration_name = "businesslbfrontendip"
  probe_id                       = azurerm_lb_probe.ssh-inbound-probe.id
  backend_address_pool_ids        = ["${azurerm_lb_backend_address_pool.business-backend-pool.id}"]
 
}

resource "azurerm_private_link_service" "privatelink1" {
  name                = "myPrivateLinkService"
  location            = data.azurerm_resource_group.rgname.location
  resource_group_name = data.azurerm_resource_group.rgname.name

  nat_ip_configuration {
    name      = "mypriatelinknatname"
    primary   = true
    subnet_id = data.azurerm_subnet.plssubnetid.id
  }

  load_balancer_frontend_ip_configuration_ids = [
    data.azurerm_lb.lb.frontend_ip_configuration.0.id
  ]
}

#Create a Private Endpoint to Private Link Service
resource "azurerm_private_link_service" "privatelink2" {
  name                = "myPrivateLinkService2"
  location            = data.azurerm_resource_group.rgname.location
  resource_group_name = data.azurerm_resource_group.rgname.name

  nat_ip_configuration {
    name      = "mypriatelinknatname"
    primary   = true
    subnet_id = data.azurerm_subnet.plssubnetid.id
  }

  load_balancer_frontend_ip_configuration_ids = [
    data.azurerm_lb.lb.frontend_ip_configuration.0.id
  ]
}