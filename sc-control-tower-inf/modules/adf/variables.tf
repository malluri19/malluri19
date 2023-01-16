variable "adfname" {}
variable "rgname" {
  type        = string
}
variable "location" {
  type        = string
  description = "Location of the azure resource group."
}
variable "dfpep" {type = string}
variable "target_resource_id" {type = string}
variable "subresource_name" {type = string}
variable "dfsqllinkname" {type = string}
variable "connection_string" {type = string}
variable "dfsqltablename" {type = string}
variable "adfprivatendpoint" {type = string}
variable "adfintrunname" {type = string}
variable "dbsname" {type = string}
variable "dbname" {type = string}
variable "collation" {type = string}
variable "sku_name" {type = string}
variable "adfmssqlpe" {type = string}