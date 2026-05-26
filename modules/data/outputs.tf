# ============================================================
# DATA MODULE - outputs.tf
# ============================================================

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.main.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault (use this to connect from App Service)"
  value       = azurerm_key_vault.main.vault_uri
}

output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = azurerm_mssql_server.main.name
}

output "sql_server_fqdn" {
  description = "Fully Qualified Domain Name of the SQL Server"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "sql_database_name" {
  description = "Name of the SQL Database"
  value       = azurerm_mssql_database.main.name
}

output "sql_admin_secret_name" {
  description = "Name of the Key Vault secret where SQL admin password is stored"
  value       = azurerm_key_vault_secret.sql_admin_password.name
}