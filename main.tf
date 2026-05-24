# ============================================================
# TOP-LEVEL main.tf
# Calls all modules to deploy the 3-tier web app
# ============================================================

terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Common tags applied to all resources
locals {
  common_tags = {
    project     = var.project_name
    environment = var.environment
    owner       = var.owner
    managed_by  = "terraform"
  }
}

# ============================================================
# Network Module - VNet, subnets, NSGs
# ============================================================
module "network" {
  source = "./modules/network"

  resource_group_name = "rg-${var.project_name}-${var.environment}"
  location            = var.location
  project_name        = var.project_name
  tags                = local.common_tags
}

# ============================================================
# Compute Module - App Service Plan + App Service
# ============================================================
module "compute" {
  source = "./modules/compute"

  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  project_name        = var.project_name
  environment         = var.environment
  app_service_sku     = var.app_service_sku
  tags                = local.common_tags

  depends_on = [module.network]
}