module "rgroup" {
  source   = "./modules/rgroup"
  rg_name  = "onpremise-RG"
  location = "canadacentral"
}

module "network" {
  source        = "./modules/network"
  location      = module.rgroup.rg_location
  rg_name       = module.rgroup.rg_name
  vnet1_name    = "onpremise-VNET"
  vnet1_space   = ["172.16.100.0/26"]
  subnet1       = "onpremise-SUBNET"
  subnet1_space = ["172.16.100.0/28"]
  nsg1          = "NSG1"
  common_tags = {
    Project     = local.common_tags.Project
    Environment = local.common_tags.Environment
    Category    = "NetworkResource"
  }
}

module "vmwindows" {
  source           = "./modules/vmwindows"
  location         = module.rgroup.rg_location
  rg_name          = module.rgroup.rg_name
  subnet_id        = module.network.subnet1_ID
  nb_count         = "1"
  vmname           = "ad-w-vm"
  winadminusername = var.winadminusername
  winpassword      = var.winpasswd
  private_ip_address = "172.16.100.5"
  timezone         = "Atlantic Standard Time"
  recurrence       = "0200"
  email            = var.email
  winOS_attribute = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
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

variable "winadminusername" {
  default = "windadmin"
}
variable "winpasswd" {
  default = "Dontusethis!"
}
variable "email" {
  default = "abc@abcdemail.com"
}
# env variable
