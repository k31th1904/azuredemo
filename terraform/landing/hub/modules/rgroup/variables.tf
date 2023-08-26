variable "rg_names" {}

variable "location" {}

variable "common_tags" {
  default = {
    Project     = ""
    Environment = ""
    Category    = ""
  }
}