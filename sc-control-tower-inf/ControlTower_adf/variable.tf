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
# variable "vnetCidr" {
#   type = string
# }
# variable "beSubnetCidr" {
#   type = string  
# }
# variable "feSubnetCidr" {
#   type = string  
# }
# variable "plsSubnetCidr" {
#   type = string  
# }
# variable "gwsubnetcidr" {
#   type = string  
# }
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
variable "rgname" {
    type = string  
}
variable "subnetname" {
    type = string  
}
# variable "besubnet" {
#     type = string  
# }
# variable "fesubnet" {
#     type = string  
# }
# variable "plssubnet" {
#     type = string  
# }
# variable "gwsubnet" {
#     type = string  
# }
variable "bepool" {
    type = string  
}
variable "inprobe" {
    type = string  
}
variable "inrulename" {
    type = string  
}
variable "feipname" {
    type = string  
}
variable "plname1" {
    type = string  
}
variable "plnatname1" {
    type = string  
}
variable "plname2" {
    type = string  
}
variable "plnatname2" {
    type = string  
}
variable "storagename" {
    type = string  
}
variable "ipconfigname" {
    type = string  
}
variable "pipaddressallocation" {
    type = string  
}
variable "vmsize" {
    type = string  
}
variable "vmpublickey" {
    type = string  
}
variable "adminuser" {
    type = string  
}
variable "osdiskcaching" {
    type = string  
}
variable "osdiskacctype" {
    type = string  
}
variable "feipconfigname" {
    type = string  
}
variable "feipconfigpipaddralloc" {
    type = string  
}
variable "adfname" {type = string}
variable "dfpep" {type = string}
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
variable "vm_kroger_shared_image_name" {
  type      = string
  description = "Name of the image from image gallery"
  default = "rhe18-image-def"
}   
variable "vm_kroger_shared_image_gallery-resource_group" {
  type = string
}
variable "vm_kroger_shared_image_version" {
  type = string
}
variable "vm_kroger_shared_image_gallery_name" {
  type = string
}
variable "nicname" {type = string}
variable "adfvnetname" {type = string}

variable "adfvnetCidr" {type = string}
variable "adfsubnet" {type = string}

variable "adfsubnetcidr" {type = string}

