#output "rg_name" {
#  value = [
#    module.rgroup.rg_name
#  ]
#}
output "vnet_name" {
  value = module.network.vnet1_name
}
output "vnet_space" {
  value = module.network.vnet1_space[0]
}
output "subnet1_name" {
  value = module.network.subnet1_name
}
output "subnet1_space" {
  value = module.network.subnet1_space[0]
}
output "nsg1_name" {
  value = module.network.nsg1_name
}
output "windows_vm_name" {
  value = module.vmwindows.windows_vm_name
}
output "windows_vm_fqdn" {
  value = module.vmwindows.windows_vm_fqdn
}
output "windows_vm_privateIP" {
  value = module.vmwindows.windows_vm_privateIP
}
output "windows_vm_publicIP" {
  value = module.vmwindows.windows_vm_publicIP
}