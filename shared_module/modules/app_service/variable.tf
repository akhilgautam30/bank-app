
variable "allowed_ip_address" {
  description = "The IP address allowed to access the app service"
  type        = string
  default     = null
}
variable "vnet_route_all_enabled" {
  description = "enables all traffic to be routed through the VNet"
  type        = string
  default     = false
}
variable "name" {
  description = "The name of the app service"
  type        = string
}

variable "location" {
  description = "The location of the app service"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the service plan"
  type        = string
}

variable "app_settings" {
  description = "A map of app settings"
  type        = map(string)
  default     = {}
}
