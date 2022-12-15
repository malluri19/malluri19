variable "rgname" {
  type        = string
}

variable "location" {
  type        = string
  description = "Location of the azure resource group."
}

variable "vnetname" {
    type = string
}

variable "vnetCidr" {
    type = string
}