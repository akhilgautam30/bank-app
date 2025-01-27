variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where resources will be created."
}

variable "location" {
  type        = string
  description = "The Azure location where resources will be deployed."
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space for the virtual network."
}

variable "subnets" {
  type        = map(string)
  description = "A map of subnets within the virtual network."
}

variable "app_gateway_name" {
  type        = string
  description = "The name of the application gateway."
}

variable "app_service_plan_name" {
  type        = string
  description = "The name of the app service plan."
}

variable "app_service_name" {
  type        = string
  description = "The name of the app service."
}
