variable "name" {
  description = "The name of the API Management service."
  type        = string
}

variable "location" {
  description = "The location/region where the API Management service will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the API Management service."
  type        = string
}

variable "publisher_name" {
  description = "The name of the publisher for the API Management service."
  type        = string
}

variable "publisher_email" {
  description = "The email of the publisher for the API Management service."
  type        = string
}

variable "sku_name" {
  description = "The SKU of the API Management service."
  type        = string
  default     = "Developer_1"
}
