locals {

  nsgrules = {

    #  ssh = {
    #    name                       = "ssh"
    #    priority                   = 210
    #    access                     = "Allow"
    #    direction                  = "Inbound"
    #    protocol                   = "Tcp"
    #    source_port_range          = "*"
    #    destination_port_range     = "22"
    #    source_address_prefix      = "*"
    #    destination_address_prefix = "*"
    #  }
    rdp = {
      name                       = "rdp"
      priority                   = 220
      access                     = "Allow"
      direction                  = "Inbound"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
    http = {
      name                       = "http"
      priority                   = 230
      access                     = "Allow"
      direction                  = "Inbound"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
    winrm = {
      name                       = "winrm"
      priority                   = 240
      access                     = "Allow"
      direction                  = "Inbound"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5985"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

  }
}