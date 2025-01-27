# modules/resource_group/main.tf
resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}

# modules/resource_group/variables.tf
variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

# modules/resource_group/outputs.tf
output "id" {
  value = azurerm_resource_group.rg.id
}

output "name" {
  value = azurerm_resource_group.rg.name
}
