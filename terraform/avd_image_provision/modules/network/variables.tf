variable "location" {
  default = "canadacentral"
}

variable "rg_name" {
  default = "avd-common-RG"
}

variable "vnet1_name" {
  default = "avdimg-VNET"
}

variable "vnet1_space" {
  default = ["192.168.100.0/26"]
}

variable "subnet1" {
  default = "avdimg-SUBNET"
}

variable "subnet1_space" {
  default = "192.168.100.0/28"
}

variable "nsg1" {
  default = "NSG1"
}

variable "common_tags" {
  default = {
    Project     = "Azure Demo"
    Environment = "AVD"
    Category    = "Network"
  }
}