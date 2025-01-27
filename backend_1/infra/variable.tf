variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "The location/location where the resources will be deployed."
}

variable "app_service_plan_name" {
  type        = string
  description = "The name of the App Service plan."
}

variable "app_service_name" {
  type        = string
  description = "The name of the App Service."
}

variable "sql_server_name" {
  type        = string
  description = "The name of the SQL server."
}

variable "sql_database_name" {
  type        = string
  description = "The name of the SQL database."
}

variable "sql_admin_username" {
  type        = string
  description = "The admin username for the SQL server."
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet."
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network (VNet)."
}

variable "apim_name" {
  type        = string
  description = "The name of the API Management service."
}

variable "publisher_name" {
  type        = string
  description = "The name of the publisher for the API Management service."
}

variable "publisher_email" {
  type        = string
  description = "The email of the publisher for the API Management service."
}

variable "password_vault_name" {
  type        = string
  description = "The name of the password vault."
}
