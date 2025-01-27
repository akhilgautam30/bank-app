
# modules/virtual_network/variables.tf
variable "name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnets" {
  type = map(string)
}
