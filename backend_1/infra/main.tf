terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
    }
  }
}

provider "azurerm" {
  features {}
}

# local state storage
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

module "resource_group" {
  source   = "../../shared_module/modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "private_endpoint" {
  source                         = "../../shared_module/modules/private_endpoint"
  name                           = "${var.sql_server_name}-pe"
  resource_group_name            = module.resource_group.name
  location                       = var.location
  subnet_id                      = data.azurerm_subnet.subnet_name.id
  private_connection_resource_id = module.sql_server.server_id
  subresource_names              = ["sqlServer"]
}

resource "azurerm_network_security_group" "backend1_nsg" {
  name                = "backend1-nsg"
  location            = var.location
  resource_group_name = module.resource_group.name

  security_rule {
    name                       = "AllowCoreBank"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "203.0.113.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DenyInternetOutbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  security_rule {
    name                       = "AllowCoreBankOutbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "203.0.113.0/24"
  }
}

resource "azurerm_subnet_network_security_group_association" "backend1_nsg_association" {
  subnet_id                 = data.azurerm_subnet.subnet_name.id
  network_security_group_id = azurerm_network_security_group.backend1_nsg.id
}

module "app_service_plan" {
  source              = "../../shared_module/modules/app_service_plan"
  name                = var.app_service_plan_name
  resource_group_name = module.resource_group.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}
    
module "app_service" {
  source              = "../../shared_module/modules/app_service"
  name                = var.app_service_name
  resource_group_name = module.resource_group.name
  location            = var.location
  service_plan_id     = module.app_service_plan.id
  vnet_route_all_enabled = true

}

module "sql_server" {
  source              = "../../shared_module/modules/sql"
  resource_group_name = module.resource_group.name
  location            = var.location
  admin_username      = var.sql_admin_username
  admin_password      = data.azurerm_key_vault_secret.database_password.value
  database_name       = var.sql_database_name
  server_name         = var.sql_server_name
  sku_name            = "S0"
}

resource "azurerm_subnet" "app_service_subnet" {
  name                 = "app-service-subnet"
  resource_group_name  = module.resource_group.name
  virtual_network_name = data.azurerm_virtual_network.data_vnet.name
  address_prefixes     = ["10.0.2.0/24"]  # assume the vnet for internal communication with database
}

resource "azurerm_subnet_network_security_group_association" "app_service_nsg_association" {
  subnet_id                 = azurerm_subnet.app_service_subnet.id
  network_security_group_id = azurerm_network_security_group.backend1_nsg.id
}

resource "azurerm_subnet_private_endpoint_network_policies" "app_service_subnet" {
  subnet_id = azurerm_subnet.app_service_subnet.id
  private_endpoint_network_policies_enabled = false
}


module "private_endpoint" {
  source                         = "../../shared_module/modules/private_endpoint"
  name                           = "${var.app_service_name}-pe"
  resource_group_name            = module.resource_group.name
  location                       = var.location
  subnet_id                      = module.virtual_network.subnet_ids["app_service"]
  private_connection_resource_id = module.app_service.id
  subresource_names              = ["sites"]
}