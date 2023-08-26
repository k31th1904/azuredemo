output "vnet1_name" {
  value = azurerm_virtual_network.vnet1.name
}
output "vnet1_space" {
  value = azurerm_virtual_network.vnet1.address_space
}
output "subnet1_name" {
  value = azurerm_subnet.subnet1.name
}
output "subnet1_space" {
  value = azurerm_subnet.subnet1.address_prefixes
}
output "subnet1_ID" {
  value = azurerm_subnet.subnet1.id
}
output "nsg1_name" {
  value = azurerm_network_security_group.nsg1.name
}
