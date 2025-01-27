resource_group_name = "bank_web_app-rg"
location = "Norway East"
vnet_name = "vnet-frontend-dev"
vnet_address_space = ["10.0.0.0/16"]
subnets = {
  app_gateway = "10.0.1.0/24"
  app_service = "10.0.2.0/24"
}
app_gateway_name = "bank-web-app-frontend-dev"
app_service_plan_name = "bank-web-app-frontend-dev"
app_service_name = "bank-web-app-frontend-dev"
