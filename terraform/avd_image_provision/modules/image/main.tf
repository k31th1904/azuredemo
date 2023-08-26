resource "time_sleep" "generalization_time" {
  create_duration = "5s"
}

resource "null_resource" "Deallocation" {

  provisioner "local-exec" {
    command = <<EOT
      az vm deallocate --resource-group ${var.rg_name} --name ${var.source_vm_name}
      az vm generalize --resource-group ${var.rg_name} --name ${var.source_vm_name}
    EOT
  }
  depends_on = [time_sleep.generalization_time]
}

resource "azurerm_image" "avdimage" {
  name                      = var.image_name
  location                  = var.location
  resource_group_name       = var.rg_name
  source_virtual_machine_id = var.source_vm_id

  os_disk {
    os_type  = var.os_type
    os_state = var.os_state
  }

  tags = var.common_tags

  timeouts {
    create = "10m"
  }
  depends_on = [null_resource.Deallocation]
}

resource "azurerm_shared_image_version" "avdimgversion" {
  name                = var.version_name
  gallery_name        = var.gallery_name
  image_name          = var.image_def_name
  resource_group_name = var.rg_name
  location            = var.location
  managed_image_id    = azurerm_image.avdimage.id

  target_region {
    name                   = var.location
    regional_replica_count = 1
    storage_account_type   = "Standard_LRS"
  }

  depends_on = [azurerm_image.avdimage]

}


