
# Create a vnet for the onprem spoke
resource "azurerm_virtual_network" "vnet-spoke-onprem" {
  name                = "vnet-onprem-spoke"
  location            = var.region
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "snet-vm-onprem" {
  name                 = "snet-onprem-vm"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-onprem.name
  address_prefixes     = ["10.0.2.0/28"]

}

 #Create a NSG for the onprem spoke
resource "azurerm_network_security_group" "snet-nsg-onprem" {
  name                = "snet-nsg-onprem"
  location            = var.region
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow_rdp"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
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



# create a public ip address for the dns
resource "azurerm_public_ip" "publicip-dns-onprem" {
  name                = "publicip-dns-onprem"
  resource_group_name = var.resource_group_name
  location            = var.region
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# create a network interface for the dns
resource "azurerm_network_interface" "nic-dns-onprem" {
  name                = "nic-dns-onprem"
  location            = var.region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet-vm-onprem.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip-dns-onprem.id
  }
}

# associate the NSG to the network interface
resource "azurerm_subnet_network_security_group_association" "sg-associate-dns-onprem" {
  subnet_id                 = azurerm_subnet.snet-vm-onprem.id
  network_security_group_id  = azurerm_network_security_group.snet-nsg-onprem.id
}

# associate the NSG to the network interface
/*resource "azurerm_subnet_network_security_group_association" "sg-associate-dns-onprem" {
  subnet_id                 = azurerm_subnet.snet-vm-onprem.id
  network_security_group_id  = azurerm_network_security_group.snet-nsg-onprem.id
}
*/

# create a random password for the dns server
resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

# create a virtual machine with a dns
resource "azurerm_windows_virtual_machine" "dns-onprem" {
  name                = "dns-onprem"
  resource_group_name = var.resource_group_name
  location            = var.region
  size                = "Standard_D2s_v3"
  admin_username        = "azureuser"
  //admin_password        = random_password.password.result
  admin_password = "@123Password"
  network_interface_ids = [
    azurerm_network_interface.nic-dns-onprem.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}


# Add provisioner to promote VM to a domain controller (Assuming Active Directory is already installed on the VM)
/*provisioner "remote-exec" {
  inline = [
    "Add-WindowsFeature AD-Domain-Services",
    "Install-ADDSForest -DomainName 'onpremise.hhs.gov' -DomainNetbiosName 'onpremise.hhs.gov' -InstallDns:$true -SafeModeAdministratorPassword (ConvertTo-SecureString 'YourAdminPasswordHere' -AsPlainText -Force) -Force",
  ]

  connection {
    type     = "ssh"
    host     = azurerm_network_interface.example.private_ip_address
    user     = "adminuser"
    password = "YourPasswordHere"
  }
}
*/
