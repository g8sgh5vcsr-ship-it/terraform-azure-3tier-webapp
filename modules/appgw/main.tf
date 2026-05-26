# ============================================================
# APPLICATION GATEWAY MODULE - main.tf
# Creates: Public IP + Application Gateway (Standard_v2 SKU)
# Routes internet traffic to App Service backend
# ============================================================

# Step 1: Public IP — the address users will hit
resource "azurerm_public_ip" "appgw" {
  name                = "${var.project_name}-appgw-pip-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

# Step 2: The Application Gateway itself
resource "azurerm_application_gateway" "main" {
  name                = "${var.project_name}-appgw-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location

  # SKU — Standard_v2 is the modern, recommended tier
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  # Where App Gateway lives in the network
  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.appgw_subnet_id
  }

  # Frontend (the entry door from the internet)
  frontend_ip_configuration {
    name                 = "frontend-public-ip"
    public_ip_address_id = azurerm_public_ip.appgw.id
  }

  # Frontend port — what port to listen on (80 = HTTP)
  frontend_port {
    name = "http-port"
    port = 80
  }

  # Backend pool — where to send traffic (your App Service)
  backend_address_pool {
    name  = "appservice-backend"
    fqdns = [var.app_service_hostname]
  }

  # Backend settings — HOW to talk to the backend
  backend_http_settings {
    name                                = "appservice-http-settings"
    cookie_based_affinity               = "Disabled"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    pick_host_name_from_backend_address = true
  }

  # HTTP listener — listens for requests on port 80
  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-public-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  # Routing rule — connect listener to backend
  request_routing_rule {
    name                       = "http-rule"
    priority                   = 100
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "appservice-backend"
    backend_http_settings_name = "appservice-http-settings"
  }

  tags = var.tags
}