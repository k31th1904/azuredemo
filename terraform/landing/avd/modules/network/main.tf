resource "azurerm_virtual_network" "vnets" {
  for_each            = var.vnets
  name                = each.key
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = each.value.address_space
  dynamic "subnet" {
    for_each = each.value.subnets
    content {
      name           = subnet.key
      address_prefix = subnet.value
    }
  }
  tags = var.common_tags
}

