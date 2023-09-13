
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
/*
  security_rule {
    name                       = "allow-winrm-https"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
  */

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
    private_ip_address_allocation = "Static" # Set to "static" to support DNS
    private_ip_address            = "10.0.2.10"
    public_ip_address_id          = azurerm_public_ip.publicip-dns-onprem.id
  }
}

# associate the NSG to the network interface
resource "azurerm_subnet_network_security_group_association" "sg-associate-dns-onprem" {
  subnet_id                 = azurerm_subnet.snet-vm-onprem.id
  network_security_group_id = azurerm_network_security_group.snet-nsg-onprem.id
}



# create a virtual machine with a dns
resource "azurerm_windows_virtual_machine" "dns-onprem" {
  name                = "dns-onprem"
  resource_group_name = var.resource_group_name
  location            = var.region
  size                = "Standard_D2s_v3"
  admin_username      = var.dns_admin_username
  admin_password      = var.dns_admin_password

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

# Install a DNS server on the virtual machine
# https://techcommunity.microsoft.com/t5/itops-talk-blog/how-to-run-powershell-scripts-on-azure-vms-with-terraform/ba-p/3827573
resource "azurerm_virtual_machine_extension" "install_dns" {
  name                 = "install_ad"
  virtual_machine_id   = azurerm_windows_virtual_machine.dns-onprem.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<SETTINGS
  {    
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.DNS.rendered)}')) | Out-File -filepath DNS.ps1\" && powershell -ExecutionPolicy Unrestricted -File DNS.ps1 -Domain_DNSName ${data.template_file.DNS.vars.Domain_DNSName}" 
  }
  SETTINGS
}

#Variable input for the DNS.ps1 script
data "template_file" "DNS" {
  template = file("${path.module}/scripts/Install-DNS.ps1")
  vars = {
    Domain_DNSName = "${var.Domain_DNSName}"
  }
}

# Install IIS web server to the virtual machine
/*resource "azurerm_virtual_machine_extension" "web_server_install" {
  name                       = "${random_pet.prefix.id}-wsi"
  virtual_machine_id         = azurerm_windows_virtual_machine.main.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
  SETTINGS
}
*/



