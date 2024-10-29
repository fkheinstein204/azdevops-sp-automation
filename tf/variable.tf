# Business Division Identifier
variable "application_name" {
  description = "Represents the business division within the larger organization that this infrastructure belongs to."
  type        = string
  default     = "AzDev"
}

# Environment Identifier
variable "environment" {
  description = "Environment identifier used as a prefix for resource names (e.g., dev, prod)."
  type        = string
  default     = "DEV"
}

# Azure Resource Location
variable "resource_group_location" {
  description = "Specifies the Azure region where the resources will be deployed."
  type        = string
  default     = "westeurope"
}

# Azure Subscription ID
variable "subscription_id" {
  description = "The Azure subscription ID under which resources will be managed."
}

# Azure Tenant ID
variable "tenant_id" {
  description = "The tenant ID associated with your Azure Active Directory instance."
}
