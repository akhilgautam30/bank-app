variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location/region where the resources will be deployed."
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan."
  type        = string
}

variable "app_service_name" {
  description = "The name of the App Service."
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database."
  type        = string
}

variable "sql_admin_username" {
  description = "The admin username for the SQL Server."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network (VNet)."
  type        = string
}

variable "apim_name" {
  description = "The name of the API Management service."
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

variable "password_vault_name" {
  description = "The name of the password vault."
  type        = string
}
