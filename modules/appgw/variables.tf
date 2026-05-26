# ============================================================
# APP GATEWAY MODULE - variables.tf
# ============================================================

variable "resource_group_name" {
  description = "Name of the resource group (from network module)"
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

variable "appgw_subnet_id" {
  description = "ID of the subnet for App Gateway (from network module)"
  type        = string
}

variable "app_service_hostname" {
  description = "Hostname of the backend App Service (from compute module)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}