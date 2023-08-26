variable "location" {
  default = "canadacentral"
}

variable "rg_name" {
  default = "avd-net-RG"
}

variable "vnets" {
  default = {
    avd-spoke-per-VNET = {
      address_space = ["192.168.0.0/22"]
      subnets = {
        perhost-SUBNET = "192.168.0.0/24"
      }
    }
    avd-spoke-pool-VNET = {
      address_space = ["192.168.4.0/22"]
      subnets = {
        poolhost-SUBNET = "192.168.4.0/24"
      }
    }
  }
}

variable "common_tags" {
  default = {
    Project     = "Azure Demo"
    Environment = "AVD"
    Category    = "NetworkResoures"
  }
}