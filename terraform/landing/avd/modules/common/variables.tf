variable "rg_name" {
  default = "avd-common-RG"
}

variable "location" {
  default = "canadacentral"
}

variable "storage1" {
  default = {
    name        = "storage1"
    tier        = "Standard"
    replication = "LRS"
  }
}
variable "storage2" {
  default = {
    name        = "storage2"
    tier        = "Standard"
    replication = "LRS"
  }
}
variable "share1" {
  default = {
    name        = "share1"
    quota       = 5
    access_tier = "Hot"
  }
}
variable "share2" {
  default = {
    name        = "share2"
    quota       = 3
    access_tier = "Hot"
  }
}

variable "sig_name" {
  default = "sig_name"
}

variable "image_def" {
  default = {
    name      = "avd"
    os_type   = "Windows"
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-22h2-avd"
  }
}

variable "common_tags" {
  default = {
    Project     = "Azure Demo"
    Environment = "AVD"
    Category    = "CommonResources"
  }
}