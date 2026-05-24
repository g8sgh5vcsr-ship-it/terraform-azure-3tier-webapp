# ============================================================
# NETWORK MODULE - variables.tf
# Inputs that the network module accepts
# ============================================================

variable "resource_group_name" {
  description = "Name of the resource group to create"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "centralus"
}

variable "project_name" {
  description = "Project_name, used as prefix for resource names"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for the Virtual Network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "web_subnet_cidr" {
  description = "CIDR block for the web subnet (App Gateway)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "app_subnet_cidr" {
  description = "CIDR block for the app subnet (App Service)"
  type        = string
  default     = "10.0.2.0/24"
}

variable "data_subnet_cidr" {
  description = "CIDR block for the data subnet (SQL private endpoint)"
  type        = string
  default     = "10.0.3.0/24"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}