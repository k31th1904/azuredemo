module "rgroup" {
  source = "./modules/rgroup"
  rg_names = {
    rg0 = "avd-net-RG"
    rg1 = "avd-RG"
    rg2 = "avd-common-RG"
  }
  location = "canadacentral"
  common_tags = {
    Project     = local.common_tags.Project
    Environment = local.common_tags.Environment
    Category    = "ResourceGroup"
  }
}

module "network" {
  source   = "./modules/network"
  location = "canadacentral"
  rg_name  = module.rgroup.rg_names[0]
  vnets = {
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

  common_tags = {
    Project     = local.common_tags.Project
    Environment = local.common_tags.Environment
    Category    = "NetworkResource"
  }
}

module "common" {
  source   = "./modules/common"
  location = "canadacentral"
  rg_name  = module.rgroup.rg_names[2]
  storage1 = {
    name        = "avdpoolprofilesa"
    tier        = "Standard"
    replication = "LRS"
  }
  storage2 = {
    name        = "avdperprofilesa"
    tier        = "Standard"
    replication = "LRS"
  }
  share1 = {
    name        = "fslogixpoolprofile"
    quota       = "3"
    access_tier = "Hot"
  }
  share2 = {
    name        = "fslogixperprofile"
    quota       = "5"
    access_tier = "Hot"
  }
  sig_name = "avdgallery"

  image_def = {
    name      = "avd-image"
    os_type   = "Windows"
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-22h2-avd"
  }

  common_tags = {
    Project     = local.common_tags.Project
    Environment = local.common_tags.Environment
    Category    = "AVDCommonResources"
  }
}

module "avd" {
  source    = "./modules/avd"
  location  = "canadacentral"
  rg_name   = module.rgroup.rg_names[2]
  workspace = "AVDDEMO-WS"
  hostpool1 = {
    name                     = "AVDDEMO-SHARED" # Name of the Azure Virtual Desktop host pool
    type                     = "Pooled"         # Type of the hostpool
    load_balancer_type       = "BreadthFirst"   # [BreadthFirst DepthFirst] load balancing method for host pool
    prefix                   = "W10-S"          # [S=shared D=dedicated] Prefix of the name of the AVD machine(s)
    maximum_sessions_allowed = 5
    dag_name                 = "W10-S-DAG"
  }
  hostpool2 = {
    name               = "AVDDEMO-DEDICATED" # Name of the Azure Virtual Desktop host pool
    type               = "Personal"          # Type of the hostpool
    load_balancer_type = "Persistent"        # [Persistent] load balancing method only for dedicated hostpool
    prefix             = "W10-D"             # [S=shared D=dedicated] Prefix of the name of the AVD machine(s)
    dag_name           = "W10-D-DAG"
  }
  rfc3339            = "2023-09-19T12:43:13Z"
  update_weekday     = "Sunday"
  update_hour        = 2
  scaling_plan1_name = "Pool Scaling Plan"
  scaling_plan2_name = "Dedicated Scaling Plan"
  timezone           = "Atlantic Standard Time"
  schedule1 = {
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
  depends_on = [module.rbac]
}

module "rbac" {
  source = "./modules/rbac"
}

#variable "winadminusername" {}
#variable "winpasswd" {}
# env variable