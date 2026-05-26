# ============================================================
# NETWORK MODULE - outputs.tf
# Values the network module gives back to the caller
# ============================================================

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.main.id
}

output "location" {
  description = "Azure region of the resource group"
  value       = azurerm_resource_group.main.location
}

output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.main.name
}

output "web_subnet_id" {
  description = "ID of the web subnet"
  value       = azurerm_subnet.web.id
}

output "app_subnet_id" {
  description = "ID of the app subnet"
  value       = azurerm_subnet.app.id
}

output "data_subnet_id" {
  description = "ID of the data subnet"
  value       = azurerm_subnet.data.id
}
output "appgw_subnet_id" {
    description = "ID of the appgw subnet"
    value       = azurerm_subnet.appgw.id
  
}