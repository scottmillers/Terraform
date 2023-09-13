




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

# Create a private resolver in the virtual network
resource "azurerm_private_dns_resolver" "private-resolver" {
  name                = "private-resolver"
  resource_group_name = var.resource_group_name
  location            = var.region
  virtual_network_id  = azurerm_virtual_network.vnet-hub.id
}

# Create a virtual network link between the hub virtual network and the private dns zone
resource "azurerm_private_dns_zone_virtual_network_link" "hub-dns-zone-link" {
  name                  = "hub-dns-zone-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dns-zone.name
  virtual_network_id    = azurerm_virtual_network.vnet-hub.id
}

# create a subnet for the private resolver inbound DNS subnet endpoint
resource "azurerm_subnet" "snet-dns-inbound" {
  name                 = "snet-dns-inbound"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = ["10.0.0.0/28"]
  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}


# create a subnet for the private resolver outbound DNS subnet endpoint
resource "azurerm_subnet" "snet-dns-outbound" {
  name                 = "snet-dns-outbound"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = ["10.0.0.16/28"]
  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

# create a private dns resolver inbound endpoint
resource "azurerm_private_dns_resolver_inbound_endpoint" "endpoint-dns-inbound" {
  name                    = "endpoint-dns-inbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.private-resolver.id
  location                = var.region
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = azurerm_subnet.snet-dns-inbound.id
  }

}

# create a private dns resolver output endpoint
resource "azurerm_private_dns_resolver_outbound_endpoint" "endpoint-dns-outbound" {
  name                    = "endpiont-dns-outbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.private-resolver.id
  location                = var.region
  subnet_id               = azurerm_subnet.snet-dns-outbound.id
}

# create a private dns resolver forwarding ruleset
resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "dns-forwarding-ruleset" {
  name                                       = "dns-forwarding-ruleset"
  resource_group_name                        = var.resource_group_name
  location                                   = var.region
  private_dns_resolver_outbound_endpoint_ids = [azurerm_private_dns_resolver_outbound_endpoint.endpoint-dns-outbound.id]
 
}

# create a virtual network link between the hub virtual network and the private dns resolver
resource "azurerm_private_dns_resolver_virtual_network_link" "dns-resolver-link" {
  name                      = "dns-resolver-link"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.dns-forwarding-ruleset.id
  virtual_network_id        = azurerm_virtual_network.vnet-hub.id
  metadata = {
    key = "value"
  }
}





