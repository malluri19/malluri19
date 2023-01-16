location              = "eastus2"
project               = "stg"
environment           = "dev"
prefix                = "ctc"
locationprefix        = ["est2"]
vnetname              = "sc-nonprod-eastus2-vnet"
# vnetCidr             = "192.168.0.0/24"
# beSubnetCidr         = "192.168.0.0/29"
# feSubnetCidr         = "192.168.0.8/29"
# plsSubnetCidr        = "192.168.0.16/29"
# gwsubnetcidr         = "192.168.0.24/29"
lbname               = "business-tier-lb"
lb_sku               = "Standard"
vmname               = "scctvm1"
rgname               = "rg-sc-ct-sandbox-eastus2"
subnetname             = "sc-ct-vm-nonprod-eastus2-sb"
# besubnet             = "besubnet"
# fesubnet             = "fesubnet"
# plssubnet            = "plssubnet"
# gwsubnet             = "gwsubnet"
bepool               = "business-backend-pool"
inprobe              = "ssh-inbound-probe"
inrulename           = "ssh-inbound-rule"
feipname             = "businesslbfrontendip"
plname1               = "myPrivateLinkService1"
plnatname1            = "mypriatelinknatname1"
plname2               = "myPrivateLinkService2"
plnatname2            = "mypriatelinknatname2"
storagename           = "stscctsand2"
vmpublickey           = "id_rsa.pub"
ipconfigname          = "internal"
pipaddressallocation  = "Dynamic"
vmsize                = "Standard_F2"
adminuser             = "adminuser"
account_replication_type = "GRS"
account_tier          = "Standard"
osdiskcaching         = "ReadWrite"
osdiskacctype         = "Standard_LRS"
feipconfigname        = "lbfrontend"
feipconfigpipaddralloc = "Dynamic"
dfpep               = "mypadfprivate1" 
subresource_name    = "blob"
adfname             = "scctadf"
dfsqllinkname       = "scctsqllink"
connection_string   = "Integrated Security=False;Data Source=test;Initial Catalog=test;User ID=sqladmin;Password=sqladmin"
dfsqltablename      = "adftable"
adfprivatendpoint  = "scctpep"
adfintrunname       = "scctadfrun"
dbsname             = "adfctdbs"
dbname              = "scctsql"
collation           = "SQL_Latin1_General_CP1_CI_AS"
sku_name            = "S3"
adfmssqlpe          = "adfscctsqlpe"
vm_kroger_shared_image_version = "21.09.010507"
vm_kroger_shared_image_gallery_name = "kt_shared_image_gallery"
vm_kroger_shared_image_gallery-resource_group = "image_gallery"
vm_kroger_shared_image_name     = "ubuntu1804-image-def"
nicname             = "scctvm1-nic"
adfvnetCidr         = "192.168.1.0/24"
adfvnetname         = "scct-sand-strg-adfvnet1"
adfsubnet           = "adfsubnet"
adfsubnetcidr       = "192.168.1.0/29"
#