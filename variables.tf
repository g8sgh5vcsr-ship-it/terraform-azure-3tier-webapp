variable "project_name" {
  description = "sahana"
  type = string
  default = "webapp"
}
variable "environment" {
    description = "dev, test, prod"
    type = string
    default = "dev"
  
}
variable "location" {
    description = "Azure region to deploy resources"
    type = string
    default = "centralus"
  
}
variable "owner" {
    description = "Owner of the resources, for tagging purposes"
    type = string
    default = "sahana"
  
}
variable "app_service_sku" {
    description = "App Service Plan SKU (F1=free, B1=basic)"
    type = string
    default = "F1"
  
}