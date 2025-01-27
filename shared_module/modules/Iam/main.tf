# modules/azuread/main.tf
resource "azuread_group" "group" {
  display_name     = var.group_name
  security_enabled = true
}

resource "azuread_group_member" "member" {
  for_each         = toset(var.member_object_ids)
  group_object_id  = azuread_group.group.id
  member_object_id = each.value
}