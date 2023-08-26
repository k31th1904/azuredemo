variable "rg_name" {
  default = "avd-RG"
}

variable "location" {
  default = "canadacentral"
}

variable "workspace" {
  default = "AVDDEMO TF Workspace"
}

variable "hostpool1" {
  default = {
    name                     = "AVDDEMO-SHARED" # Name of the Azure Virtual Desktop host pool
    type                     = "Pooled"         # Type of the hostpool
    load_balancer_type       = "BreadthFirst"   # [BreadthFirst DepthFirst] load balancing method for host pool
    prefix                   = "W10-S"          # [S=shared D=dedicated] Prefix of the name of the AVD machine(s)
    maximum_sessions_allowed = 5
    dag_name                 = "W10-S-DAG"
  }
  description = "Shared hostpool for Azure Virtual Desktop"
}

variable "hostpool2" {
  default = {
    name               = "AVDDEMO-DEDICATED" # Name of the Azure Virtual Desktop host pool
    type               = "Personal"          # Type of the hostpool
    load_balancer_type = "Persistent"        # [Persistent] load balancing method only for dedicated hostpool
    prefix             = "W10-D"             # [S=shared D=dedicated] Prefix of the name of the AVD machine(s)
    dag_name           = "W10-D-DAG"
  }
  description = "Dedicated hostpool for Azure Virtual Desktop"
}

variable "update_weekday" {
  default = "Sunday"
}

variable "update_hour" {
  default = 2
}

variable "scaling_plan_name" {
  default = "Auto Scaling Plan"
}

variable "timezone" {
  default = "Eastern Standard Time"
}

variable "rfc3339" {
  default = "2023-09-20T12:43:13Z"
}

variable "schedule1" {
  default = {
    name                                 = "Weekdays"
    days_of_week                         = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    ramp_up_start_time                   = "05:00"
    ramp_up_load_balancing_algorithm     = "BreadthFirst"
    ramp_up_minimum_hosts_percent        = 20
    ramp_up_capacity_threshold_percent   = 10
    peak_start_time                      = "09:00"
    peak_load_balancing_algorithm        = "BreadthFirst"
    ramp_down_start_time                 = "19:00"
    ramp_down_load_balancing_algorithm   = "DepthFirst"
    ramp_down_minimum_hosts_percent      = 10
    ramp_down_force_logoff_users         = false
    ramp_down_wait_time_minutes          = 45
    ramp_down_notification_message       = "Please log off in the next 45 minutes..."
    ramp_down_capacity_threshold_percent = 5
    ramp_down_stop_hosts_when            = "ZeroSessions"
    off_peak_start_time                  = "22:00"
    off_peak_load_balancing_algorithm    = "DepthFirst"
  }
}

variable "common_tags" {
  default = {
    Project     = "Azure Demo"
    Environment = "AVD"
    Category    = "AVD"
  }
}