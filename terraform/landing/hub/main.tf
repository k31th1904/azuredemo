module "rgroup" {
  source = "./modules/rgroup"
  rg_names = {
    rg0 = "net-RG"
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
  source        = "./modules/network"
  location      = "canadacentral"
  rg_name       = module.rgroup.rg_names[0]
  vnets = {
    hub-VNET = {
      address_space = ["172.16.0.0/22"]
      subnets = {
        vpngw-SUBNET   = "172.16.0.0/26"
        fw-SUBNET      = "172.16.0.64/26"
        bastion_SUBNET = "172.16.0.128/26"
        dns_SUBNET     = "172.16.1.0/24"
      }
    }
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


variable "winadminusername" {}
variable "winpasswd" {}
# env variable