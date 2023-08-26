resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet1_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.vnet1_space
  tags                = var.common_tags

}

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1
  resource_group_name  = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = var.subnet1_space
}

resource "azurerm_network_security_group" "nsg1" {
  name                = var.nsg1
  location            = azurerm_virtual_network.vnet1.location
  resource_group_name = azurerm_virtual_network.vnet1.resource_group_name
  tags                = var.common_tags

}

resource "azurerm_network_security_rule" "rules" {
  for_each                    = local.nsgrules
  name                        = each.key
  priority                    = each.value.priority
  access                      = each.value.access
  direction                   = each.value.direction
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  network_security_group_name = azurerm_network_security_group.nsg1.name
  resource_group_name         = azurerm_virtual_network.vnet1.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "association1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}
