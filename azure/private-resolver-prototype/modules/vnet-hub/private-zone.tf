
# Create a private dns zone for the hub virtual network
resource "azurerm_private_dns_zone" "private-dns-zone" {
  name                = var.private_zone_name
  resource_group_name = var.resource_group_name
}


# Create a virtual network link between the hub virtual network and the private dns zone and setup autoregisteration
resource "azurerm_private_dns_zone_virtual_network_link" "hub-private-dns-zone-link" {
  name                  = "hub-private-dns-zone-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private-dns-zone.name
  virtual_network_id    = azurerm_virtual_network.vnet-hub.id
  registration_enabled = true
}