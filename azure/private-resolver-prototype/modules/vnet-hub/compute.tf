

######################
# Virtual Machine One
######################
# create a virtual machine

# create a public ip address for the vm
resource "azurerm_public_ip" "publicip-vm-one" {
  name                = "publicip-vm-one"
  resource_group_name = var.resource_group_name
  location            = var.region
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# create a network interface for the vm
resource "azurerm_network_interface" "nic-vm-one" {
  name                = "nic-vm-one"
  location            = var.region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "vm-one-ipconfig"
    subnet_id                     = azurerm_subnet.snet-vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip-vm-one.id
  }
}



# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm-one" {
  name                  = "vm-one"
  location              = var.region
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic-vm-one.id]
  size                  = "Standard_DS1_v2"
  computer_name         = "bepvmone"
  admin_username        = var.vm_username

  os_disk {
    name                 = "vmone-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }


  admin_ssh_key {
    username   = var.vm_username
    public_key = var.ssh_public_key
  }



}

resource "azurerm_virtual_machine_extension" "ext-vm-one" {
  name                 = "ext-vm-one"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-one.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
 {
  "script": "${base64encode(file("${path.module}/scripts/setup.sh"))}"
 
 }
SETTINGS
}

#Variable input for the setup.sh script
/*
data "template_file" "setup" {
  template = file("${path.module}/scripts/setup.sh")
  vars = {
    private_zone_name = "${var.private_zone_name}"
  }
}
*/

######################
# Virtual Machine Two
######################
# create a virtual machine
# create a public ip address for the vm
resource "azurerm_public_ip" "publicip-vm-two" {
  name                = "publicip-vm-two"
  resource_group_name = var.resource_group_name
  location            = var.region
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# create a network interface for the vm
resource "azurerm_network_interface" "nic-vm-two" {
  name                = "nic-vm-two"
  location            = var.region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "vm-two-ipconfig"
    subnet_id                     = azurerm_subnet.snet-vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip-vm-two.id
  }
}



# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm-two" {
  name                  = "vm-two"
  location              = var.region
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic-vm-two.id]
  size                  = "Standard_DS1_v2"
  computer_name         = "bepvmtwo"
  admin_username        = var.vm_username

  os_disk {
    name                 = "vm-two-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }


  admin_ssh_key {
    username   = var.vm_username
    public_key = var.ssh_public_key
  }


}

resource "azurerm_virtual_machine_extension" "ext-vm-two" {
  name                 = "ext-vm-two"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-two.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
 {
  "script": "${base64encode(file("${path.module}/scripts/setup.sh"))}"
 
 }
SETTINGS
}

#Variable input for the setup.sh script
/*
data "template_file" "setup" {
  template = file("${path.module}/scripts/setup.sh")
  vars = {
    private_zone_name = "${var.private_zone_name}"
  }
}
*/