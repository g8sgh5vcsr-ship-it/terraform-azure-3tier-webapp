variable "resource_group_name" {
    description = "Name of the resource group to create"
    type        = string
  
}
variable "location" {
    description = "Azure region where resources will be created"
    type        = string
  
}
variable "project_name" {
    description = "Project_name, used as prefix for resource names"
    type        = string
  
}
variable "app_service_principal_id" {
    description = "Principal ID of the App Service Managed Identity (passed from compute module)"
    type        = string
  
}
variable "sql_sku" {
    description = "SQL Database SKU (S0, S1, S2, etc.)"
    type        = string
    default     = "GP_S_Gen5_1"
  
}
variable "tags" {
    description = "Tags to apply to all resources"
    type        = map(string)
    default     = {}
  
}