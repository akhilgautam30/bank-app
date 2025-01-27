# modules/private_endpoint/main.tf

resource "azurerm_private_endpoint" "endpoint" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name}-connection"
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection           = false
    subresource_names              = var.subresource_names
  }
}

resource "azurerm_private_dns_zone" "app_service_zone" {
  name                = "${var.name}-privatelink.azurewebsites.net"
  resource_group_name = module.resource_group.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "app_service_zone_link" {
  name                  = "${var.name}-app_service_zone_link"
  resource_group_name   = module.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.app_service_zone.name
  virtual_network_id    = module.virtual_network.id
}

resource "azurerm_private_dns_a_record" "app_service_record" {
  name                = module.app_service.name
  zone_name           = azurerm_private_dns_zone.app_service_zone.name
  resource_group_name = module.resource_group.name
  ttl                 = 300
  records             = [module.private_endpoint.private_ip_address]
}

# modules/private_endpoint/variables.tf

variable "name" {
  type        = string
  description = "The name of the private endpoint"
}

variable "location" {
  type        = string
  description = "The location/location where the private endpoint is created"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the private endpoint"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet from which private IP addresses will be allocated for this Private Endpoint"
}

variable "private_connection_resource_id" {
  type        = string
  description = "The ID of the resource to which the private endpoint will be connected"
}

variable "subresource_names" {
  type        = list(string)
  description = "A list of subresource names which the Private Endpoint is able to connect to"
}

# modules/private_endpoint/outputs.tf

output "id" {
  value       = azurerm_private_endpoint.endpoint.id
  description = "The ID of the Private Endpoint"
}

output "private_ip_address" {
  value       = azurerm_private_endpoint.endpoint.private_service_connection[0].private_ip_address
  description = "The private IP address associated with the private endpoint"
}
