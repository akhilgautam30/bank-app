// Define the data source to get the virtual network
data "azurerm_virtual_network" "data_vnet" {
  name                = var.vnet_name
  resource_group_name = module.resource_group.name
}

// Define the data source to get the subnet
data "azurerm_subnet" "subnet_name" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.data_vnet.name
  resource_group_name  = data.azurerm_virtual_network.data_vnet.resource_group_name
}

#data module 
data "azurerm_key_vault" "database_valut_name" {
  name                = var.password_vault_name
  resource_group_name = module.resource_group.name
}

data "azurerm_key_vault_secret" "database_password" {
  name         = "sql-admin-password"
  key_vault_id = data.azurerm_key_vault.database_valut_name.id
}