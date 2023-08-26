output "storage1_account_endpoint" {
  value = azurerm_storage_account.storage1.primary_blob_endpoint
}

output "storage2_account_endpoint" {
  value = azurerm_storage_account.storage2.primary_blob_endpoint
}

output "storage1_name" {
  value = azurerm_storage_account.storage1.name
}

output "storage2_name" {
  value = azurerm_storage_account.storage2.name
}

output "sig_name" {
  value = azurerm_shared_image_gallery.sig.name
}