variable "resource_group_name" {
  description = "Name of the resource group (passed from network module)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "project_name" {
  description = "Project name, used as prefix"
  type        = string
}
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "app_service_sku" {
  description = "App Service Plan SKU (F1=free, B1=basic ~$13/mo)"
  type        = string
  default     = "B1"
}
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}