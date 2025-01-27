# modules/appgateway/main.tf
resource "azurerm_application_gateway" "appgateway" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = "${var.name}-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "${var.name}-feport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${var.name}-feip"
    public_ip_address_id = var.public_ip_id
  }

  backend_address_pool {
    name = "${var.name}-beap"
    fqdns = var.backend_fqdns

  }

  backend_http_settings {
    name                  = "${var.name}-be-htst"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 443 
    protocol              = "Http"
    request_timeout       = 60
    host_name             = var.backend_fqdns[0]

  }

  http_listener {
    name                           = "${var.name}-httplstn"
    frontend_ip_configuration_name = "${var.name}-feip"
    frontend_port_name             = "${var.name}-feport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${var.name}-rqrt"
    rule_type                  = "Basic"
    http_listener_name         = "${var.name}-httplstn"
    backend_address_pool_name  = "${var.name}-beap"
    backend_http_settings_name = "${var.name}-be-htst"
  }
}