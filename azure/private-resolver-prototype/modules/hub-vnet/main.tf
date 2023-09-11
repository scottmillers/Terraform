# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}




# Create the first virtual network that simulates the Hub
resource "azurerm_virtual_network" "vnet-hub" {
  name                = "vnet-hub"
  address_space       = ["10.0.0.0/24"]
  location            = var.region
  resource_group_name = var.resource_group_name
}

# Create a private dns zone for the hub virtual network
resource "azurerm_private_dns_zone" "dns-zone" {
  name                = "bep.hhs.gov"
  resource_group_name = var.resource_group_name
}

# Create a virtual network link between the hub virtual network and the private dns zone
resource "azurerm_private_dns_zone_virtual_network_link" "hub-dns-zone-link" {
  name                  = "hub-dns-zone-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dns-zone.name
  virtual_network_id    = azurerm_virtual_network.vnet-hub.id
}

# create the hub virtual network inbound DNS subnet
resource "azurerm_subnet" "snet-dns-inbound" {
  name                 = "snet-dns-inbound"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = ["10.0.0.0/28"]
}

resource "azurerm_subnet" "snet-dns-outbound" {
  name                 = "snet-dns-outbound"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = ["10.0.0.16/28"]
}


