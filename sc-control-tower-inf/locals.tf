locals {
  // unless default is overridden, source ip whitelist from whitelist-helper
  cidr_json    = jsondecode(data.http.ip_whitelist.body)
  ip_whitelist = var.ip_whitelist != ["158.48.0.1"] ? var.ip_whitelist : concat([for _ in local.cidr_json : _._cidrNoSlash32 if lower(_.group) == "kroger"], [for _ in local.cidr_json : _._cidrNoSlash32 if lower(_.group) == "8451"])
  
  # Tags
  tags = {
    application-name = "controltower"
    cost-center      = "2091-6025040"
    lob              = "SCMF TECH"
    owner            = "gAD6845SCSubAdmin@kproductivity.onmicrosoft.com"
    spm-id           = "9264"
  }
}