variable "rg_name" {
  default = "avd-common-RG"
}

variable "location" {
  default = "canadacentral"
}


variable "common_tags" {
  default = {
    Project     = "Azure Demo"
    Environment = "AVD"
    Category    = "ResourceGroup"
  }
}