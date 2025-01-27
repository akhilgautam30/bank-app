variable "server_name" {
  description = "The name of the SQL server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location/region where the SQL server is created."
  type        = string
}

variable "sql_version" {
  description = "The version of the SQL server."
  type        = string
  default     = "12.0"
}

variable "admin_username" {
  description = "The administrator username for the SQL server."
  type        = string
}

variable "admin_password" {
  description = "The administrator password for the SQL server."
  type        = string
}

variable "database_name" {
  description = "The name of the SQL database."
  type        = string
}

variable "collation" {
  description = "The collation of the SQL database."
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "license_type" {
  description = "The license type for the SQL server."
  type        = string
  default     = "LicenseIncluded"
}

variable "max_size_gb" {
  description = "The maximum size of the SQL database in gigabytes."
  type        = number
  default     = 2
}

variable "sku_name" {
  description = "The SKU name for the SQL server."
  type        = string
  default     = "S0"
}