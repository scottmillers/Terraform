




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
/*resource "azurerm_subnet" "snet-dns-inbound" {
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
*/


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
/*resource "azurerm_private_dns_resolver_inbound_endpoint" "endpoint-dns-inbound" {
  name                    = "endpoint-dns-inbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.private-resolver.id
  location                = var.region
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = azurerm_subnet.snet-dns-inbound.id
  }

}
*/
# create a private dns resolver output endpoint
resource "azurerm_private_dns_resolver_outbound_endpoint" "endpoint-dns-outbound" {
  name                    = "endpoint-dns-outbound"
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

resource "azurerm_private_dns_resolver_forwarding_rule" "dns-forwarding-rule-onpremise" {
  name                      = "dns-forwarding-rule-onpremise"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.dns-forwarding-ruleset.id
  domain_name               = "onpremise.hhs.gov"
  enabled                   = true
  target_dns_servers {
    ip_address = "10.0.2.10"
    port       = 53
  }
  metadata = {
    key = "value"
  }
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

# create a subnet for the vm
resource "azurerm_subnet" "snet-vm" {
  name                 = "snet-vm"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = ["10.0.0.32/28"]
}

# create a security rule for the vm
resource "azurerm_network_security_group" "snet-nsg-vm" {
  name                = "snet-nsg-vm"
  location            = var.region
  resource_group_name = var.resource_group_name
   security_rule {
    name                       = "allow_ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_dns"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


# create a public ip address for the vm
resource "azurerm_public_ip" "publicip-vm-hub" {
  name                = "publicip-dns-onprem"
  resource_group_name = var.resource_group_name
  location            = var.region
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# create a network interface for the vm
resource "azurerm_network_interface" "nic-vm-hub" {
  name                = "nic-dns-onprem"
  location            = var.region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "vm"
    subnet_id                     = azurerm_subnet.snet-vm.id
    private_ip_address_allocation = "Dynamic" 
    public_ip_address_id          = azurerm_public_ip.publicip-vm-hub.id
  }
}

# associate the NSG to the network interface
resource "azurerm_subnet_network_security_group_association" "sg-associate-vm-hub" {
  subnet_id                 = azurerm_subnet.snet-vm
  network_security_group_id = azurerm_network_security_group.snet-nsg-vm
}


# Create virtual machine
resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  name                  = "myVM"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.my_terraform_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "hostname"
  admin_username = var.username

  admin_ssh_key {
    username   = var.username
    public_key = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }
}











