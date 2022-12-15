module "resourcegroup" {
    source              = "../modules/resource_group"
    rgname              = format("%s-%s-%s-%s-rg", var.prefix, var.location, var.environment, var.project)
    location            = var.location
}

