# module "virtualnetwork" {
#     source              = "../modules/virtual_network"
#     rgname              = var.rgname
#     location            = var.location
#     vnetname            = var.vnetname
#     vnetCidr            = var.vnetCidr
# }
# module "besubnet" {
#     source              = "../modules/subnet"
#     rgname              = var.rgname
#     location            = var.location
#     subnetname          = var.besubnet
#     vnetname            = var.vnetname
#     SubnetCidr          = var.beSubnetCidr
#     depends_on = [
#       module.virtualnetwork
#     ]
# }
# module "fesubnet" {
#     source              = "../modules/subnet"
#     rgname              = var.rgname
#     location            = var.location
#     subnetname          = var.fesubnet
#     vnetname            = var.vnetname
#     SubnetCidr          = var.feSubnetCidr
#     depends_on = [
#       module.virtualnetwork
#     ]
# }
# module "plssubnet" {
#     source              = "../modules/subnet"
#     rgname              = var.rgname
#     location            = var.location
#     subnetname          = var.plssubnet
#     vnetname            = var.vnetname
#     SubnetCidr          = var.plsSubnetCidr
#     depends_on = [
#       module.virtualnetwork
#     ]
# }
# module "gwsubnet" {
#     source              = "../modules/subnet"
#     rgname              = var.rgname
#     location            = var.location
#     subnetname          = var.gwsubnet
#     vnetname            = var.vnetname
#     SubnetCidr          = var.gwsubnetcidr
#     depends_on = [
#       module.virtualnetwork
#     ]
# }
module "adfsubnet" {
    source              = "../modules/subnet"
    rgname              = var.rgname
    location            = var.location
    subnetname          = var.adfsubnet
    vnetname            = var.adfvnetname
    SubnetCidr          = var.adfsubnetcidr
    depends_on = [
      module.adfvirtualnetwork
    ]
}
module "loadbalancer" {
    source              = "../modules/loadbalancer"
    rgname              = var.rgname
    location            = var.location
    lbname              = var.lbname
    lb_sku              = var.lb_sku
    subnet_id           = data.azurerm_subnet.subnetid.id
    feipconfigname      = var.feipconfigname
    feipconfigpipaddralloc = var.feipconfigpipaddralloc
    depends_on = [
      data.azurerm_subnet.subnetid
    ]
}
# #Create Backend Address Pool
resource "azurerm_lb_backend_address_pool" "business-backend-pool" {
  loadbalancer_id = data.azurerm_lb.lb.id
  name            = var.bepool
    depends_on = [
      module.loadbalancer
    ]
}

#Create Probe
resource "azurerm_lb_probe" "ssh-inbound-probe" {
  loadbalancer_id     = data.azurerm_lb.lb.id
  name                = var.inprobe
  port                = 22
  # resource_group_name = data.azurerm_resource_group.rgname.name
    depends_on = [
      module.loadbalancer
    ]
}

#Create Loadbalancing Rules
resource "azurerm_lb_rule" "inbound-rules" {
  loadbalancer_id                = data.azurerm_lb.lb.id
  name                           = var.inrulename
  # resource_group_name            = var.rgname
  protocol                       = "Tcp"
  frontend_port                  = 1433
  backend_port                   = 1433
  frontend_ip_configuration_name = var.feipconfigname
  probe_id                       = azurerm_lb_probe.ssh-inbound-probe.id
  backend_address_pool_ids       = ["${azurerm_lb_backend_address_pool.business-backend-pool.id}"]
    depends_on = [
      module.loadbalancer
    ] 
}

module "adfvirtualnetwork" {
    source              = "../modules/virtual_network"
    rgname              = var.rgname
    location            = var.location
    vnetname            = var.adfvnetname
    vnetCidr            = var.adfvnetCidr
}


resource "azurerm_private_link_service" "privatelink1" {
  name                = var.plname1
  location            = data.azurerm_resource_group.rgname.location
  resource_group_name = data.azurerm_resource_group.rgname.name

  nat_ip_configuration {
    name      = var.plnatname1
    primary   = true
    subnet_id = data.azurerm_subnet.subnetid.id
  }

  load_balancer_frontend_ip_configuration_ids = [
    data.azurerm_lb.lb.frontend_ip_configuration.0.id
  ]
  depends_on = [
    module.loadbalancer
    # module.plssubnet
  ]
}