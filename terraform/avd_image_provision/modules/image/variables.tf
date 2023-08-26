variable "location" {
  default = "canadacentral"
}
variable "rg_name" {
  default = "avd-common-RG"
}
variable "image_name" {
  default = "avd_image"
}
variable "source_vm_id" {
  default = ""
}
variable "source_vm_name" {
  default = ""
}
variable "os_type" {
  default = "Windows"
}
variable "os_state" {
  default = "Generalized"
}
variable "gallery_name" {
  default = "avdgallery"
}
variable "image_def_name" {
  default = "avd-image"
}
variable "version_name" {
  default = "0.0.1"
}
variable "common_tags" {
  default = {
    Project     = "Azure Demo"
    Environment = "AVD"
    Category    = "image"
  }
}