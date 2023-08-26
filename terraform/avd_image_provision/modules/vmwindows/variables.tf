variable "rg_name" {
  default = "avd-common-RG"
}
variable "location" {
  default = "canadacentral"
}
variable "subnet_id" {
  default = ""
}
variable "nb_count" {
  default = 1
}
variable "vmname" {
  default = "azuredemo-w-vm"
}
variable "winpip_att" {
  default = {
    sku               = "Standard"
    allocation_method = "Static"
  }
}
variable "private_ip_address_allocation" {
  default = "Dynamic"
}
variable "vmsize" {
  default = "Standard_B2s"
}
variable "winadminusername" {
  default = "winadmin"
}
variable "winpassword" {
  default = "PleaseChangeTh1s!"
}

variable "windisk_attributes" {
  default = {
    type    = "Standard_LRS"
    size    = 128
    caching = "ReadWrite"
  }
}
variable "winOS_attribute" {
  default = {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "22h2-avd"
    version   = "latest"
  }
}

variable "extension1" {
  default = {
    publisher                  = "Microsoft.Azure.Security"
    type                       = "IaaSAntimalware"
    type_handler_version       = "1.3"
    auto_upgrade_minor_version = "true"
  }
}


variable "common_tags" {
  default = {
    Project     = "Azure Demo"
    Environment = "AVD"
    Category    = "vmwindows"
  }
}