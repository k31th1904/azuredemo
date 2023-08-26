variable "location" {
  default = "canadacentral"
}

variable "rg_name" {}

variable "vnets" {}



variable "common_tags" {
  default = {
    Project     = ""
    Environment = ""
    Category    = ""
  }
}