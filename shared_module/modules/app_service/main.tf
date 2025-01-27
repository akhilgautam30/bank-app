
resource "azurerm_linux_web_app" "app" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id
  site_config {
    vnet_route_all_enabled = var.vnet_route_all_enabled
    always_on = true
    ip_restriction {
      ip_address = var.allowed_ip_address
      action     = "Allow"
      priority   = 100
      name       = "Allow Application Gateway"
    }
  }

  app_settings = var.app_settings
}