# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.72.0"
    }


  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# See https://registry.terraform.io/modules/cloudposse/label/null/latest for documentation
module "label" {
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



resource "azurerm_resource_group" "rg" {
  name     = "private-resolver-prototype"
  location = "southcentralus"
}


module "vnet-hub" {
  source = "./modules/vnet-hub"
  # insert the 2 required variables here
  resource_group_name = azurerm_resource_group.rg.name
  region              = azurerm_resource_group.rg.location
}

/*
module "vnet-spoke-onprem" {
  source = "./modules/vnet-spoke-onpremise"
  # insert the 2 required variables here
  resource_group_name = azurerm_resource_group.rg.name
  region              = azurerm_resource_group.rg.location
}
*/

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
