resource "azurerm_storage_account" "storage1" {
  name                     = var.storage1.name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.storage1.tier
  account_replication_type = var.storage1.replication
  tags                     = var.common_tags
}

resource "azurerm_storage_account" "storage2" {
  name                     = var.storage2.name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.storage2.tier
  account_replication_type = var.storage2.replication
  tags                     = var.common_tags
}

resource "azurerm_storage_share" "share1" {
  name                 = var.share1.name
  storage_account_name = azurerm_storage_account.storage1.name
  quota                = var.share1.quota
}

resource "azurerm_storage_share" "share2" {
  name                 = var.share2.name
  storage_account_name = azurerm_storage_account.storage2.name
  quota                = var.share2.quota
}

resource "azurerm_shared_image_gallery" "sig" {
  name                = var.sig_name
  resource_group_name = var.rg_name
  location            = var.location
  tags                = var.common_tags
}

resource "azurerm_shared_image" "def1" {
  name                = var.image_def.name
  resource_group_name = var.rg_name
  location            = azurerm_shared_image_gallery.sig.location
  gallery_name        = azurerm_shared_image_gallery.sig.name
  os_type             = var.image_def.os_type

  identifier {
    publisher = var.image_def.publisher
    offer     = var.image_def.offer
    sku       = var.image_def.sku
  }
  tags = var.common_tags
}
