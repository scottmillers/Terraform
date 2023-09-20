
// create vnet peering between hub and onprem spoke
resource "azurerm_virtual_network_peering" "vnet-hub_to_vnet-spoke-onprem" {
  name                         = "vnet-hub_to_vnet-spoke-onprem"
  resource_group_name          = azurerm_resource_group.rg-hub-vnet.name
  virtual_network_name         = module.vnet-hub.vnet_name
  remote_virtual_network_id    = module.vnet-spoke-onprem.vnet_id
  allow_virtual_network_access = true
}


// create vnet peering between onprem spoke and hub
resource "azurerm_virtual_network_peering" "vnet-spoke-onprem_to_vnet-hub" {
  name                         = "vnet-spoke-onprem_to_vnet-hub"
  resource_group_name          = azurerm_resource_group.rg-on-prem-vnet.name
  virtual_network_name         = module.vnet-spoke-onprem.vnet_name
  remote_virtual_network_id    = module.vnet-hub.vnet_id
  allow_virtual_network_access = true
}


// create vnet peering between hub and application spoke
resource "azurerm_virtual_network_peering" "vnet-hub_to_vnet-application-spoke" {
  name                         = "vnet-hub_to_vnet-application-spoke"
  resource_group_name          = azurerm_resource_group.rg-hub-vnet.name
  virtual_network_name         = module.vnet-hub.vnet_name
  remote_virtual_network_id    = module.vnet-spoke-application.vnet_id
  allow_virtual_network_access = true
}

// create vnet peering between application spoke and hub
resource "azurerm_virtual_network_peering" "vnet-spoke-application_to_vnet-hub" {
  name                         = "vnet-spoke-application_to_vnet-hub"
  resource_group_name          = azurerm_resource_group.rg-application-vnet.name
  virtual_network_name         = module.vnet-spoke-application.vnet_name
  remote_virtual_network_id    = module.vnet-hub.vnet_id
  allow_virtual_network_access = true
}



