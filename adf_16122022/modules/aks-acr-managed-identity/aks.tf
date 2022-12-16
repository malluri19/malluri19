resource "azurerm_kubernetes_cluster" "aks" {
  name                = format("%s-%s-aks", var.name, var.environment)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = formart("%s-%s-aks-%s", var.dns_prefix, var.name, var.environment)
  depends_on          = ["azurerm_role_assignment.aks_network", "azurerm_role_assignment.aks_acr"]

  agent_pool_profile {
    name            = "default"
    count           = "${var.node_count}"
    vm_size         = "${var.node_type}"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "${azuread_application.default.application_id}"
    client_secret = "${azuread_service_principal_password.default.value}"
  }

  role_based_access_control {
    enabled = true
  }
}