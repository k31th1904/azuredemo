resource "azurerm_public_ip" "winpip" {
  count               = var.nb_count
  name                = "${var.vmname}-pip-${format("%1d", count.index + 1)}"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.winpip_att.allocation_method
  domain_name_label   = "${var.vmname}${format("%1d", count.index + 1)}"
  sku                 = var.winpip_att.sku
  tags                = var.common_tags
}

resource "azurerm_network_interface" "winnic" {
  count               = var.nb_count
  name                = "${var.vmname}-nic-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${var.vmname}-ipconfig-${format("%1d", count.index + 1)}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address = var.private_ip_address
    public_ip_address_id          = element(azurerm_public_ip.winpip[*].id, count.index + 1)
  }
  depends_on = [azurerm_public_ip.winpip]
  tags       = var.common_tags
}

resource "azurerm_windows_virtual_machine" "winvm" {
  count                 = var.nb_count
  name                  = "${var.vmname}${format("%1d", count.index + 1)}"
  computer_name         = "${var.vmname}${format("%1d", count.index + 1)}"
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [element(azurerm_network_interface.winnic[*].id, count.index + 1)]
  size                  = var.vmsize
  admin_username        = var.winadminusername
  admin_password        = var.winpassword
  # Refer to environment variable

  os_disk {
    name                 = "${var.vmname}-os-disk${format("%1d", count.index + 1)}"
    caching              = var.windisk_attributes.caching
    storage_account_type = var.windisk_attributes.type
    disk_size_gb         = var.windisk_attributes.size
  }


  source_image_reference {
    publisher = var.winOS_attribute.publisher
    offer     = var.winOS_attribute.offer
    sku       = var.winOS_attribute.sku
    version   = var.winOS_attribute.version
  }

  winrm_listener {
    protocol = "Http"
  }

  #boot_diagnostics {
  #  storage_account_uri = var.storage_account_endpoint
  #}
  tags = var.common_tags
}

resource "azurerm_virtual_machine_extension" "extension1" {
  count = var.nb_count
  name  = var.extension1.type

  virtual_machine_id         = element(azurerm_windows_virtual_machine.winvm[*].id, count.index + 1)
  publisher                  = var.extension1.publisher
  type                       = var.extension1.type
  type_handler_version       = var.extension1.type_handler_version
  auto_upgrade_minor_version = var.extension1.auto_upgrade_minor_version
  depends_on = [
    azurerm_windows_virtual_machine.winvm,
  ]
  tags = var.common_tags
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "schedule" {
  count              = var.nb_count
  virtual_machine_id = element(azurerm_windows_virtual_machine.winvm[*].id, count.index + 1)
  location           = var.location
  enabled            = true

  daily_recurrence_time = var.recurrence
  timezone              = var.timezone

  notification_settings {
    enabled         = true
    email           = var.email
    time_in_minutes = "60"
  }
}