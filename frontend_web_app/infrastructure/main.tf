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

module "virtual_network" {
  source              = "../../shared_module/modules/virtual_network"
  name                = var.vnet_name
  resource_group_name = module.resource_group.name
  address_space       = var.vnet_address_space
  subnets             = var.subnets
  location            = var.location
}

module "application_gateway" {
  source               = "../../shared_module/modules/application_gateway"
  name                 = var.app_gateway_name
  resource_group_name  = module.resource_group.name
  location             = var.location
  subnet_id            = module.virtual_network.subnet_ids["app_gateway"]
  public_ip_id         = "10:10:10:10"
  backend_fqdns = [module.app_service.default_hostname]

  backend_http_settings = {
    name                  = "appServiceHttpSetting"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 60
    host_name             = module.app_service.default_hostname
  }
}


module "app_service_plan" {
  source              = "../../shared_module/modules/app_service_plan"
  name                = var.app_service_plan_name
  resource_group_name = module.resource_group.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "S1"
}

module "app_service" {
  source               = "../../shared_module/modules/app_service"
  name                 = var.app_service_name
  resource_group_name  = module.resource_group.name
  location             = var.location
  service_plan_id      = module.app_service_plan.id
  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14.15.1"
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
  # comment out the allowed_ip_address variable because this adds cyclic dependency and WAF should be the part of overall cloud configuraion 
  #allowed_ip_address = module.application_gateway.private_ip_address
}

resource "azurerm_app_service_source_control" "source_control" {
  app_id   = module.app_service.id
  repo_url = "https://github.com/akhilgautam30/pai_site.git"
  branch   = "main"

  github_action_configuration {
    generate_workflow_file = true
  }
}

# resource "null_resource" "set_allowed_ip_address" {
#   provisioner "local-exec" {
#     command = <<EOT
#       az webapp config access-restriction add --resource-group ${module.resource_group.name} --name ${module.app_service.name} --rule-name "Allow Application Gateway" --action Allow --ip-address ${module.application_gateway.private_ip_address} --priority 100
#     EOT
#   }
# }