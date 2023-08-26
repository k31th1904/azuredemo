output "subnets_info" {
  value = { 
    for vnet in azurerm_virtual_network.vnets : vnet.name => {
      for s in vnet.subnet : s.name => s.address_prefix
    }
  }
}

output "vnets_info" {
  value = {
    for vnet in azurerm_virtual_network.vnets : vnet.name => vnet.address_space
  }
}

#output "subnet1_space" {
#  value = azurerm_subnet.subnet1.address_prefixes
#}
#output "subnet1_ID" {
#  value = azurerm_subnet.subnet1.id
#}

