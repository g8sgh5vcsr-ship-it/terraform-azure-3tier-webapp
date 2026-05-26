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

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = module.data.key_vault_name
}

output "sql_server_fqdn" {
  description = "SQL Server FQDN"
  value       = module.data.sql_server_fqdn
}

output "sql_database_name" {
  description = "Name of the SQL Database"
  value       = module.data.sql_database_name
}
output "appgw_public_ip" {
    description = "Public IP of the Application Gateway"
    value       = module.appgw.public_ip_address
  
}
output "appgw_url" {
    description = "URL of the Application Gateway (visit this!)"
    value       = "https://${module.appgw.public_ip_address}"
  
}