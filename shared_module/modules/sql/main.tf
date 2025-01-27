
# modules/sql/main.tf

resource "azurerm_mssql_server" "server" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
}

resource "azurerm_mssql_database" "database" {
  name           = var.database_name
  server_id      = azurerm_mssql_server.server.id
  collation      = var.collation
  license_type   = var.license_type
  max_size_gb    = var.max_size_gb
  sku_name       = var.sku_name
}

