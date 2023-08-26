resource "azurerm_resource_group" "rgs" {
  for_each = var.rg_names
  name     = each.value
  location = var.location
  tags     = var.common_tags
}