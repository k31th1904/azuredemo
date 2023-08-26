resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = var.workspace
  resource_group_name = var.rg_name
  location            = var.location
  friendly_name       = var.workspace
}

resource "azurerm_virtual_desktop_host_pool" "hostpool1" {
  resource_group_name      = var.rg_name
  location                 = var.location
  name                     = var.hostpool1.name
  friendly_name            = var.hostpool1.name
  validate_environment     = true
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;"
  type                     = var.hostpool1.type
  maximum_sessions_allowed = var.hostpool1.maximum_sessions_allowed
  load_balancer_type       = var.hostpool1.load_balancer_type
  start_vm_on_connect      = true
  scheduled_agent_updates {
    enabled = true
    schedule {
      day_of_week = "Sunday"
      hour_of_day = 2
    }
  }
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo1" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool1.id
  expiration_date = var.rfc3339
}

resource "azurerm_virtual_desktop_application_group" "dag1" {
  resource_group_name = var.rg_name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool1.id
  location            = var.location
  type                = "Desktop"
  name                = var.hostpool1.dag_name
  friendly_name       = var.hostpool1.dag_name
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool1, azurerm_virtual_desktop_workspace.workspace]
}

resource "azurerm_virtual_desktop_host_pool" "hostpool2" {
  resource_group_name   = var.rg_name
  location              = var.location
  name                  = var.hostpool2.name
  friendly_name         = var.hostpool2.name
  validate_environment  = true
  custom_rdp_properties = "audiocapturemode:i:1;audiomode:i:0;"
  type                  = var.hostpool2.type
  load_balancer_type    = var.hostpool2.load_balancer_type
  start_vm_on_connect   = true
  scheduled_agent_updates {
    enabled = true
    schedule {
      day_of_week = var.update_weekday
      hour_of_day = var.update_hour
    }
  }
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo2" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool2.id
  expiration_date = var.rfc3339
}

resource "azurerm_virtual_desktop_application_group" "dag2" {
  resource_group_name = var.rg_name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool2.id
  location            = var.location
  type                = "Desktop"
  name                = var.hostpool2.dag_name
  friendly_name       = var.hostpool2.dag_name
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool2, azurerm_virtual_desktop_workspace.workspace]
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag1" {
  application_group_id = azurerm_virtual_desktop_application_group.dag1.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag2" {
  application_group_id = azurerm_virtual_desktop_application_group.dag2.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}

resource "azurerm_virtual_desktop_scaling_plan" "scaling_plan1" {
  name                = var.scaling_plan1_name
  location            = var.location
  resource_group_name = var.rg_name
  friendly_name       = var.scaling_plan1_name
  time_zone           = var.timezone
  schedule {
    name                                 = var.schedule1.name
    days_of_week                         = var.schedule1.days_of_week
    ramp_up_start_time                   = var.schedule1.ramp_up_start_time
    ramp_up_load_balancing_algorithm     = var.schedule1.ramp_up_load_balancing_algorithm
    ramp_up_minimum_hosts_percent        = var.schedule1.ramp_up_minimum_hosts_percent
    ramp_up_capacity_threshold_percent   = var.schedule1.ramp_up_capacity_threshold_percent
    peak_start_time                      = var.schedule1.peak_start_time
    peak_load_balancing_algorithm        = var.schedule1.peak_load_balancing_algorithm
    ramp_down_start_time                 = var.schedule1.ramp_down_start_time
    ramp_down_load_balancing_algorithm   = var.schedule1.ramp_down_load_balancing_algorithm
    ramp_down_minimum_hosts_percent      = var.schedule1.ramp_down_minimum_hosts_percent
    ramp_down_force_logoff_users         = var.schedule1.ramp_down_force_logoff_users
    ramp_down_wait_time_minutes          = var.schedule1.ramp_down_wait_time_minutes
    ramp_down_notification_message       = var.schedule1.ramp_down_notification_message
    ramp_down_capacity_threshold_percent = var.schedule1.ramp_down_capacity_threshold_percent
    ramp_down_stop_hosts_when            = var.schedule1.ramp_down_stop_hosts_when
    off_peak_start_time                  = var.schedule1.off_peak_start_time
    off_peak_load_balancing_algorithm    = var.schedule1.off_peak_load_balancing_algorithm
  }
  host_pool {
    hostpool_id          = azurerm_virtual_desktop_host_pool.hostpool1.id
    scaling_plan_enabled = true
  }
  depends_on = [azurerm_virtual_desktop_host_pool.hostpool1]
}

