# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.72.0"
    }


    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }

  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# See https://registry.terraform.io/modules/cloudposse/label/null/latest for documentation
/*module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  # insert the 12 required variables here
  namespace  = "hhs"
  stage      = "dev"
  name       = "private-resolver-prototype"
  attributes = ["public"]
  delimiter  = "-"

  tags = {
    "BusinessUnit" = "CTO",
    "Snapshot"     = "true"
  }
}
*/

resource "azurerm_resource_group" "rg-hub-vnet" {
  name     = "hub-vnet"
  location = var.region
}

resource "azurerm_resource_group" "rg-on-prem-vnet" {
  name     = "on-prem-vnet"
  location = var.region
}



module "vnet-hub" {
  source = "./modules/vnet-hub"
  # insert the 2 required variables here
  resource_group_name = azurerm_resource_group.rg-hub-vnet.name
  region              = var.region
  vm_username         = "azureuser"
  ssh_public_key      = tls_private_key.ssh.public_key_openssh
}


module "vnet-spoke-onprem" {
  source = "./modules/vnet-spoke-onpremise"
  # insert the 2 required variables here
  resource_group_name = azurerm_resource_group.rg-on-prem-vnet.name
  region              = var.region
  dns_admin_username  = "azureuser"
}


// create vnet peering between hub and spoke
resource "azurerm_virtual_network_peering" "vnet-hub_to_vnet-spoke-onprem" {
  name                         = "vnet-hub_to_vnet-spoke-onprem"
  resource_group_name          = azurerm_resource_group.rg-hub-vnet.name
  virtual_network_name         = module.vnet-hub.vnet-name
  remote_virtual_network_id    = module.vnet-spoke-onprem.vnet-id
  allow_virtual_network_access = true
}

// create vnet peering between spoke and hub
resource "azurerm_virtual_network_peering" "vnet-spoke-onprem_to_vnet-hub" {
  name                         = "vnet-spoke-onprem_to_vnet-hub"
  resource_group_name          = azurerm_resource_group.rg-on-prem-vnet.name
  virtual_network_name         = module.vnet-spoke-onprem.vnet-name
  remote_virtual_network_id    = module.vnet-hub.vnet-id
  allow_virtual_network_access = true
}


/*
resource "azurerm_linux_virtual_machine" "onprem-vm" {
  name                = "onprem-vm"
  resource_group_name = var.resource_group_name
  location            = var.region
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
*/
