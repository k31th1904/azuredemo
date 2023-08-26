output "rg_names" {
  value = module.rgroup.rg_names
}

output "subnets_info" {
  value = module.network.subnets_info
}

output "vnets_info" {
  value = module.network.vnets_info
}

output "pool_storage_account_endpoint" {
  value = module.common.storage1_account_endpoint
}

output "person_storage_account_endpoint" {
  value = module.common.storage2_account_endpoint
}

output "pool_storage_name" {
  value = module.common.storage1_name
}

output "person_storage_name" {
  value = module.common.storage2_name
}

output "compute_gallery_name" {
  value = module.common.sig_name
}