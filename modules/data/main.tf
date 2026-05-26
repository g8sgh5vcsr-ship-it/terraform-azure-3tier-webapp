# ============================================================
# DATA MODULE - main.tf
# Creates: Key Vault, SQL Server, SQL Database
# Grants App Service access to Key Vault via Managed Identity
# ============================================================

# Get current Azure tenant info (needed for Key Vault)
data "azurerm_client_config" "current" {}

# Random password for SQL admin (we'll store it in Key Vault)
resource "random_password" "sql_admin" {
  length      = 24
  special     = true
  min_lower   = 2
  min_upper   = 2
  min_numeric = 2
  min_special = 2
}

# Random suffix for globally unique names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}

# ============================================================
# KEY VAULT - secure storage for secrets
# ============================================================
resource "azurerm_key_vault" "main" {
  name                = "${var.project_name}-kv-${random_string.suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  # RBAC mode — modern security model (uses roles instead of access policies)
  enable_rbac_authorization = true

  tags = var.tags
}

# Allow YOU (the deployer) to manage secrets in Key Vault
resource "azurerm_role_assignment" "current_user_kv_admin" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Allow the App Service to READ secrets from Key Vault
resource "azurerm_role_assignment" "app_service_kv_reader" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.app_service_principal_id
}

# Store the SQL admin password in Key Vault
resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  value        = random_password.sql_admin.result
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.current_user_kv_admin]
}

# ============================================================
# SQL SERVER - the database "server"
# ============================================================
resource "azurerm_mssql_server" "main" {
  name                         = "${var.project_name}-sql-${random_string.suffix.result}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = random_password.sql_admin.result

  tags = var.tags
}

# Allow Azure services to connect to SQL Server (for App Service)
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# ============================================================
# SQL DATABASE - the actual database
# ============================================================
resource "azurerm_mssql_database" "main" {
  name      = "${var.project_name}-db"
  server_id = azurerm_mssql_server.main.id
  sku_name  = var.sql_sku
  
  # Save money — auto-pause when not in use
  auto_pause_delay_in_minutes = 60
  min_capacity                = 0.5

  tags = var.tags
}