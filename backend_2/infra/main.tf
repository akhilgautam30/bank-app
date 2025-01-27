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

module "app_service_plan" {
  source              = "../../shared_module/modules/app_service_plan"
  name                = var.app_service_plan_name
  resource_group_name = module.resource_group.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

# App Service
module "app_service" {
  source              = "../../shared_module/modules/app_service"
  name                = var.app_service_name
  resource_group_name = module.resource_group.name
  location            = var.location
  service_plan_id     = module.app_service_plan.id
  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14.15.1"
  }
}

# Database (Azure SQL)
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

# Private Endpoint for SQL Server
module "private_endpoint" {
  source                  = "../../shared_module/modules/private_endpoint"
  name                    = "${var.sql_server_name}-pe"
  resource_group_name     = module.resource_group.name
  location                = var.location
  subnet_id               = data.azurerm_subnet.subnet_name.id
  private_connection_resource_id = module.sql_server.server_id
  subresource_names       = ["sqlServer"]
}

# API Management
module "api_management" {
  source              = "../../shared_module/modules/api_management"
  name                = var.apim_name
  resource_group_name = module.resource_group.name
  location            = var.location
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = "Developer_1"
}

# API
resource "azurerm_api_management_api" "backend2_api" {
  name                = "backend2-api"
  resource_group_name = module.resource_group.name
  api_management_name = module.api_management.name
  revision            = "1"
  display_name        = "Backend Service 2 API"
  path                = "api"
  protocols           = ["https"]
}

# API Rate Limit Policy
resource "azurerm_api_management_api_policy" "rate_limit_policy" {
  api_name            = azurerm_api_management_api.backend2_api.name
  api_management_name = module.api_management.name
  resource_group_name = module.resource_group.name

  xml_content = <<XML
<policies>
  <inbound>
    <rate-limit-by-key calls="10" renewal-period="1" counter-key="@(context.Request.IpAddress)" />
  </inbound>
</policies>
XML
}
