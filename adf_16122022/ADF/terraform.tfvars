# storage_name          = ["stgaccountnameeastus","stgaccountnamecentralus","stgaccount3"]
# account_tier          = ["Standard","Standard","Standard"]
location              = "eastus2"
project               = "arun"
environment           = "dev"
prefix                = "ctc"
locationprefix        = ["est2"]
# rgname                = "example-rg-name"
vnetname              = ""
vnetCidr             = "10.0.0.0/16"
beSubnetCidr         = "10.10.0.0/24"
feSubnetCidr         = "10.20.0.0/24"
plsSubnetCidr        = "10.30.0.0/24"
gwsubnetcidr         = "10.40.0.0/24"
lbname               = "business-tier-lb"
lb_sku               = "Standard"
vmname               = "myvm-machine-01"
account_replication_type    = "GRS"
account_tier        = "Standard"
storage_name          = "stgaccountnameeastus"
dfped               = "" 
target_resource_id  = ""
subresource_name    = ""
adfname             = ""
dfsqllinkname       = ""
connection_string   = "Integrated Security=False;Data Source=test;Initial Catalog=test;User ID=test;Password=test"
dfsqltablename      = ""
adfprivatendpoint2  = ""
adfintrunname       = ""
dbsname             = ""
dbname              = ""
collation           = ""
sku_name            = ""
adfmssqlpe          = ""