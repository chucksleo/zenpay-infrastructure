resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = var.app_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontendIpConfig"
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  backend_address_pool {
    name = "backendAddressPool"
  }

  backend_http_settings {
    name                  = "backendHttpSettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "appGwHttpListener"
    frontend_ip_configuration_name = "frontendIpConfig"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "appGwHttpListener"
    backend_address_pool_name  = "backendAddressPool"
    backend_http_settings_name = "backendHttpSettings"
    priority = 100 # Set the priority here
  }
}

output "app_gateway_public_ip" {
  value = azurerm_public_ip.app_gateway_public_ip.ip_address
}
