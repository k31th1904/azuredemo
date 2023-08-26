data "azuread_service_principal" "avd_sp" { # Get AVD principal ID
  display_name = "Windows Virtual Desktop"
}

data "azurerm_role_definition" "avd_def" { # access an existing built-in role
  name = "Desktop Virtualization Power On Off Contributor"
}

data "azurerm_subscription" "subscription1" { # get subscription id
}

resource "azurerm_role_assignment" "avd_role_assign" { # supports Auto Scale and start on connect action
  scope              = data.azurerm_subscription.subscription1.id
  role_definition_id = data.azurerm_role_definition.avd_def.id
  principal_id       = data.azuread_service_principal.avd_sp.id
}


