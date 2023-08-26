module "network" {
  source        = "./modules/network"
  location      = var.location
  rg_name       = var.rg_name
  vnet1_name    = "avdimg-VNET"
  vnet1_space   = ["192.168.100.0/26"]
  subnet1       = "avdimg-SUBNET"
  subnet1_space = ["192.168.100.0/28"]
  nsg1          = "NSG1"
  common_tags = {
    Project     = local.common_tags.Project
    Environment = local.common_tags.Environment
    Category    = "NetworkResource"
  }
}

module "vmwindows" {
  source           = "./modules/vmwindows"
  location         = var.location
  rg_name          = var.rg_name
  subnet_id        = module.network.subnet1_ID
  nb_count         = "1"
  vmname           = "azuredemo-w-vm"
  winadminusername = var.winadminusername
  winpassword      = var.winpasswd
  winOS_attribute = {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-22h2-avd"
    version   = "latest"
  }
  common_tags = {
    Project     = local.common_tags.Project
    Environment = local.common_tags.Environment
    Category    = "vmwindows"
  }
}

module "ansible" {
  source          = "./modules/ansible"
  windows_vm_fqdn = module.vmwindows.windows_vm_fqdn
  windows_var = {
    user     = var.winadminusername
    password = var.winpasswd
  }
  depends_on = [module.vmwindows]
}

module "image" {
  source         = "./modules/image"
  location       = var.location
  rg_name        = var.rg_name
  image_name     = "avd-image"
  source_vm_id   = module.vmwindows.windows_vm_id[0]
  source_vm_name = module.vmwindows.windows_vm_name[0]
  os_type        = "Windows"
  os_state       = "Generalized"
  version_name   = "0.0.1"
  gallery_name   = "avdgallery"
  image_def_name = "avd-image"
  depends_on     = [module.ansible]
}

variable "winadminusername" {}
variable "winpasswd" {}
variable "location" {
  default = "canadacentral"
}
variable "rg_name" {
  default = "avd-common-RG"
}
# env variable