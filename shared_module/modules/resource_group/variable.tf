variable "name" {
  description = "The name of the application gateway"
}

variable "resource_group_name" {
  description = "The name of the resource group"
}

variable "location" {
  description = "The location/region where the application gateway is created"
}

variable "sku_name" {
  description = "The SKU name of the application gateway"
  default     = "Standard_v2"
}

variable "sku_tier" {
  description = "The SKU tier of the application gateway"
  default     = "Standard_v2"
}

variable "capacity" {
  description = "The capacity of the application gateway"
  default     = 2
}

variable "subnet_id" {
  description = "The ID of the subnet where the application gateway is deployed"
}

variable "public_ip_id" {
  description = "The ID of the public IP associated with the application gateway"
}

variable "backend_fqdns" {
  description = "List of FQDNs for the backend pool"
  type        = list(string)
}

variable "backend_http_settings" {
  description = "Settings for the backend HTTP configuration"
  type = object({
    name                  = string
    cookie_based_affinity = string
    path                  = string
    port                  = number
    protocol              = string
    request_timeout       = number
    host_name             = string
  })
}