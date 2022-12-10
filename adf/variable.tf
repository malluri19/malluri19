variable "location" {
  type        = string
  description = "(Optional) The location for resource deployment"
}

variable "environment" {
  type        = string
  description = "(Required) Three character environment name"

  validation {
    condition     = length(var.environment) <= 3
    error_message = "Err: Environment cannot be longer than three characters."
  }
}

variable "project" {
  type        = string
  description = "(Required) The project name"
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