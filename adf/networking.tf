#Vnet creation
resource "azurerm_virtual_network" "vNet" {
  name = format("vnet1-%s-%s-%s", var.location, var.environment, var.project)

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  address_space = [var.vnetCidr]
}

resource "azurerm_subnet" "besubnet" {
  name = "be-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.vNet.name
  address_prefixes     = [var.beSubnetCidr]
}

resource "azurerm_subnet" "fesubnet" {
  name = "fe-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.vNet.name
  address_prefixes     = [var.feSubnetCidr]
}

resource "azurerm_subnet" "plssubnet" {
  name = "pls-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.vNet.name
  address_prefixes     = [var.plsSubnetCidr]
}

resource "azurerm_subnet" "gwsubnet" {
  name = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.vNet.name
  address_prefixes     = [var.gwsubnetcidr]
}

#Create Load Balancer
resource "azurerm_lb" "business-tier-lb" {
  name                = "business-tier-lb"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "lbfrontendip"
    subnet_id                     = azurerm_subnet.fesubnet.id
    # private_ip_address            = var.env == "Static" ? var.private_ip : null
    private_ip_address_allocation = "Dynamic"
  }
}

#Create Backend Address Pool
resource "azurerm_lb_backend_address_pool" "business-backend-pool" {
  loadbalancer_id = azurerm_lb.business-tier-lb.id
  name            = "business-backend-pool"
}

#Create Probe
resource "azurerm_lb_probe" "ssh-inbound-probe" {
  loadbalancer_id     = azurerm_lb.business-tier-lb.id
  name                = "ssh-inbound-probe"
  port                = 22
}

#Create Loadbalancing Rules
resource "azurerm_lb_rule" "inbound-rules" {
  loadbalancer_id                = azurerm_lb.business-tier-lb.id
  name                           = "ssh-inbound-rule"
  protocol                       = "Tcp"
  frontend_port                  = 1433
  backend_port                   = 1433
  frontend_ip_configuration_name = "businesslbfrontendip"
  probe_id                       = azurerm_lb_probe.ssh-inbound-probe.id
  backend_address_pool_ids        = ["${azurerm_lb_backend_address_pool.business-backend-pool.id}"]
 
}

resource "azurerm_private_link_service" "example" {
  name                = "myPrivateLinkService"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  nat_ip_configuration {
    name      = "mypriatelinknatname"
    primary   = true
    subnet_id = azurerm_subnet.plssubnet.id
  }

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.business-tier-lb.frontend_ip_configuration.0.id,
  ]
}

#Create a Private Endpoint to Private Link Service
resource "azurerm_private_link_service" "example" {
  name                = "myPrivateLinkService2"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  nat_ip_configuration {
    name      = "mypriatelinknatname"
    primary   = true
    subnet_id = azurerm_subnet.plssubnet.id
  }

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.business-tier-lb.frontend_ip_configuration.0.id,
  ]
}