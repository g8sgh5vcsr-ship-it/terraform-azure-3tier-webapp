# ============================================================
# COMPUTE MODULE - outputs.tf
# ============================================================

output "app_service_name" {
  description = "Name of the App Service"
  value       = azurerm_linux_web_app.main.name
}

output "app_service_id" {
  description = "ID of the App Service"
  value       = azurerm_linux_web_app.main.id
}

output "app_service_url" {
  description = "Default URL of the App Service"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "app_service_principal_id" {
  description = "Managed Identity Principal ID (used by Key Vault later)"
  value       = azurerm_linux_web_app.main.identity[0].principal_id
}

output "service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.main.id
}