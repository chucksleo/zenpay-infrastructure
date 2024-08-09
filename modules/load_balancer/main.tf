resource "azurerm_public_ip" "lb_public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "load_balancer" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = "backend-pool"
}

resource "azurerm_lb_probe" "http_probe" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = "http-probe"
  protocol        = "Http"
  port            = 80
  request_path    = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

output "lb_public_ip" {
  value = azurerm_public_ip.lb_public_ip.ip_address
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.backend_pool.id
}
