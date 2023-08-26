output "rg_names" {
  value = values(azurerm_resource_group.rgs)[*].name
}
output "rg_location" {
  value = values(azurerm_resource_group.rgs)[*].location
}
