
# Create the second virtual network that simulates the on-premises network Spoke
resource "azurerm_virtual_network" "vnet-spoke-onprem" {
  name                = "myvnet-onprem-spoke"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["12.0.0.0/8"]
}

resource "azurerm_subnet" "backendsubnet" {
  name                 = "backendsubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-onprem.name
  address_prefixes     = ["12.0.0.0/24"]

}

 Create two VMs in the hub subnet


# Create a VM in the backend subnet
# create a virtual machine with a public network interface instance in the backend subnet
resource "azurerm_public_ip" "onprem-vm-nic-publicip" {
  name                = "onprem-vm-nic-publicip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}
resource "azurerm_network_interface" "onprem-vm-nic" {
  name                = "onprem-vm-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.backendsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.onprem-vm-nic-publicip.id
  }
}



resource "azurerm_linux_virtual_machine" "onprem-vm" {
  name                = "onprem-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"

  admin_username = "adminuser"
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  network_interface_ids = [
    azurerm_network_interface.onprem-vm-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
