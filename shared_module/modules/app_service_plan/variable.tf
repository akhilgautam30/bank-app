
variable "name" {
  description = "The name of the App Service Plan."
  type        = string
}

variable "location" {
  description = "The location/region where the App Service Plan will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the App Service Plan."
  type        = string
}

variable "os_type" {
  description = "The operating system type for the App Service Plan (e.g., Windows or Linux)."
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the App Service Plan (e.g., F1, B1, P1v2)."
  type        = string
}
