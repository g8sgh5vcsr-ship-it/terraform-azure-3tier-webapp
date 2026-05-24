# ============================================================
# TOP-LEVEL outputs.tf
# ============================================================

output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.network.resource_group_name
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = module.network.vnet_name
}

output "location" {
  description = "Azure region used"
  value       = module.network.location
}

output "app_service_name" {
  description = "Name of the App Service"
  value       = module.compute.app_service_name
}

output "app_service_url" {
  description = "URL of the App Service (visit this!)"
  value       = module.compute.app_service_url
}