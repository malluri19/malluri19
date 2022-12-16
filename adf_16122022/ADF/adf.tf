module "adf" {
    source              = "../modules/adf"
    adfname             = var.adfname
    rgname              = data.azurerm_resource_group.rgname.name
    location            = var.location
    dfped               = var.dfped
    target_resource_id  = var.target_resource_id
    subresource_name    = var.subresource_name
    dfsqllinkname       = var.dfsqllinkname
    connection_string   = var.connection_string
    dfsqltablename      = var.dfsqltablename
    adfprivatendpoint2  = var.adfprivatendpoint2
    adfintrunname       = var.adfintrunname
    dbsname             = var.dbsname
    dbname              = var.dbname
    collation           = var.collation
    sku_name            = var.sku_name
    adfmssqlpe          = var.adfmssqlpe
}