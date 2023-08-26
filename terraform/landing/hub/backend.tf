terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-RG"
    storage_account_name = "tfstateremotebackendsa"
    container_name       = "tfstate-landing"
    key                  = "tfstate"
  }
}