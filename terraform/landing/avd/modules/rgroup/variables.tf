variable "rg_names" {
  default = {
    rg_names = {
      rg0 = "avd-net-RG"
      rg1 = "avd-RG"
      rg2 = "avd-common-RG"
    }
  }
}

variable "location" {
  default = "canadacentral"
}

variable "common_tags" {
  default = {
    Project     = "Azure Demo"
    Environment = "AVD"
    Category    = "ResourceGroups"
  }
}