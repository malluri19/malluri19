variable "tenant_id" {
  description = "Azure Active Directory tenant ID"
  default     = "8331e14a-9134-4288-bf5a-5e2c8412f074"
}

variable "terraform_github_sp_object_id" {
  description = "Object ID of service principal that is used to deploy terraform through github"
  default     = "ff408d91-bf10-4237-8ab2-195715b0e2d5"
}

variable "environment" {
  description = "Name of the environment (dev, test, etc)"
  default     = "sandbox"
}

variable "location" {
  description = "Name of the resource group location"
  default     = "East US 2"
}

variable "os_type" {
  description = "Name of the OS to be used for service plan"
  default     = "Linux"
}

variable "location_abbr" {
  description = "Name of the resource group location"
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "rg-sc-ct-sandbox-eastus2"
}

variable "virtual-network_address" {
  description = "Array of address_space IPs for virtual-network"
  default     = ["10.0.0.0/16"]
}

variable "subnet_address" {
  description = "Array of address_prefixes IPs for subnet"
  default     = ["10.0.2.0/24"]
}

variable "bypass" {
  description = "network rules bypass"
  default = [
    "Metrics",
    "Logging",
    "AzureServices"
  ]
}

variable "account_tier" {
  description = "The storage account tier"
  default     = "Standard"
}

variable "account_kind" {
  description = "The storage account kind"
  default     = "StorageV2"
}

variable "storage_account_replication_type" {
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are LRS*, GRS, RAGRS and ZRS."
  default     = "LRS"
}

variable "cross_tenant_replication_enabled" {
  description = "(Optional) Should cross Tenant replication be enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "enable_https_traffic_only" {
  default = true
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2."
  default     = "TLS1_2" # Kroger prefers TLS1_2 but isn't fully enforced yet
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow public access to all blobs or containers in the storage account."
  default     = false
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "access_tier" {
  type        = string
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."
  default     = "Hot"
}

# the default is Deny per the azure-policies, this cannot be set to allow without having an exemption in github.com/krogertechnology/azure-policies
variable "network_default_action" {
  description = "network default action"
  default     = "Deny"
}

variable "identity_system_assigned" {
  description = "Type of Managed Service Identity that should be configured"
  default     = "SystemAssigned"
}

# the default value here is to trigger interpolocation of the values from github.com/krogertechnology/whitelist-helper see data.tf and locals.tf unless an override is provided by consumer
variable "ip_whitelist" {
  description = "until a more maintainable solution becomes available, restrict access to trusted carrier grade IP space"
  default     = ["158.48.0.1"]
}

variable "additional_ip_whitelist" {
  type        = list(string)
  description = "additional authorized ip addresses to  be whitelisted. This list is concatenated with ip_whitelist"
  default     = []
}

variable "advanced_threat_protection" {
  default = true
}

variable "sku_log_analytics" {
  description = "The SKU (pricing level) of the Log Analytics workspace"
  default     = "PerGB2018"
  type        = string
}

variable "sku_service_plan" {
  description = "The SKU (pricing level) of the App Service Plan"
  default     = "S1"
  type        = string
}

variable "sku_search_service" {
  description = "(Required) The SKU which should be used for this Search Service. Possible values are basic, free, standard, standard2, standard3, storage_optimized_l1 and storage_optimized_l2. Changing this forces a new Search Service to be created."
  default     = "standard"
  type        = string
}

variable "application_type" {
  description = "(Required) Specifies the type of Application Insights to create. Valid Values- ios, java, MobileCenter, Node.JS, other, phone, store and web."
  type        = string
  nullable    = false
  default = "web"
}

variable "daily_data_cap_in_gb" {
  description = "(Optional) Specifies the Application Insights component daily data volume cap in GB."
  type        = number
  default     = null
}

variable "daily_data_cap_notification_disabled" {
  description = "(Optional) Specifies if a notification email will be send when the daily data volume cap is met."
  type        = bool
  default     = null
}

variable "retention_in_days" {
  description = "(Optional) Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90."
  type        = number
  default     = 30
}

variable "sampling_percentage" {
  description = "(Optional) Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry."
  type        = number
  default     = null
}

variable "disable_ip_masking" {
  description = "(Optional) By default the real client IP is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client IP. Defaults to false."
  type        = bool
  default     = null
}

variable "local_authentication_disabled" {
  description = "(Optional) Disable Non-Azure AD based Auth. Defaults to false."
  type        = bool
  default     = null
}


variable "internet_ingestion_enabled" {
  description = "(Optional) Should the Application Insights component support ingestion over the Public Internet? Defaults to true."
  type        = bool
  default     = null
}

variable "internet_query_enabled" {
  description = " (Optional) Should the Application Insights component support querying over the Public Internet? Defaults to true."
  type        = bool
  default     = null
}

variable "force_customer_storage_for_profiler" {
  description = "(Optional) Should the Application Insights component force users to create their own storage account for profiling? Defaults to false."
  type        = bool
  default     = null
}

variable "functions_extension_version" {
  description = "The functions extension version to be used"
  default     = "~4"
  type        = string
}

variable "service_endpoints" {
  type        = list(string)
  description = "(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  default     = ["Microsoft.Storage"]
}

variable "role_definition_name" {
  description = " (Optional) The name of a built-in Role. Changing this forces a new resource to be created. Conflicts with role_definition_id."
  default     = "Storage Table Data Contributor"
  type        = string
}