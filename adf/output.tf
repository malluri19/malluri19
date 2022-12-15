output "rgname" {
    value = data.azurerm_resource_group.rgname.name
}
output "subnet_id" {
    value = data.azurerm_subnet.besubnetid.id
}

output "lb_id" {
    value = data.azurerm_lb.lb.id
}