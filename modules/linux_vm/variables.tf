variable "rgname" {
  type        = string
}
variable "location" {
  type        = string
  description = "Location of the azure resource group."
}
variable "nicname" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "vmname" {
  type = string
}