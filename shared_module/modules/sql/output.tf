output "server_name" {
  value = azurerm_mssql_server.server.name
}

output "server_id" {
  value = azurerm_mssql_server.server.id
}

output "database_name" {
  value = azurerm_mssql_database.database.name
}
