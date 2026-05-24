#create : APP Service plan and App Service
# The App Service plan defines the underlying compute resources for the App Service. The App Service is the web application that will run on the App Service plan. Both resources are tagged with project and environment information for better organization and management in Azure.

resource "azurerm_service_plan" "main" {
  name                = "${var.project_name}-asp-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku

  tags = var.tags
}
# The App Service - where the web app runs
resource "azurerm_linux_web_app" "main" {
  name                = "${var.project_name}-app-${var.environment}-${random_string.suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      python_version = "3.11"
    }

    always_on = false  # required for free/basic tiers
  }
  # Enable Managed Identity (we'll use this with Key Vault later)
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Random suffix to make App Service name globally unique
resource "random_string" "suffix" {
  length  = 6
  special = false
   upper   = false
  numeric = true
}