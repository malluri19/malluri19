variable "project" {
  type        = string
}
variable "environment" {
  type        = string
  description = "Name of the deployment environment"
}
variable "prefix" {
  type        = string
}
variable "locationprefix" {
  type = list(string)
}
variable "location" {
  type = string
}
# variable "rgname" {
#   type = string
# }
variable "vnetname" {
  type = string
}
variable "vnetCidr" {
  type = string
}
variable "beSubnetCidr" {
  type = string  
}
variable "feSubnetCidr" {
  type = string  
}
variable "plsSubnetCidr" {
  type = string  
}
variable "gwsubnetcidr" {
  type = string  
}
variable "lbname" {
    type = string
}
variable "lb_sku" {
    type = string
}
variable "vmname" {
    type = string
}
variable "account_tier" {
    type = string
  
}
variable "account_replication_type" {
    type = string  
}

variable "adfname" {type = string}
variable "dfped" {type = string}
variable "target_resource_id" {type = string}
variable "subresource_name" {type = string}
variable "dfsqllinkname" {type = string}
variable "connection_string" {type = string}
variable "dfsqltablename" {type = string}
variable "adfprivatendpoint2" {type = string}
variable "adfintrunname" {type = string}
variable "dbsname" {type = string}
variable "dbname" {type = string}
variable "collation" {type = string}
variable "sku_name" {type = string}
variable "adfmssqlpe" {type = string}