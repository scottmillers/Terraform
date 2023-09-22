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

// create the resource group for the hub virtual network
resource "azurerm_resource_group" "rg-hub-vnet" {
  name     = "hub-vnet"
  location = var.region
}

// create the resource group for the spoke application virtual network
resource "azurerm_resource_group" "rg-application-vnet" {
  name     = "application-vnet"
  location = var.region
}

// create the resource group for the spoke on-premise virtual network
resource "azurerm_resource_group" "rg-on-prem-vnet" {
  name     = "on-prem-vnet"
  location = var.region
}

// create the on-premise virtual network components
module "vnet-spoke-onprem" {
  source              = "./modules/vnet-spoke-onpremise"
  resource_group_name = azurerm_resource_group.rg-on-prem-vnet.name
  region              = var.region
  dns_admin_username  = var.vm_username
  ssh_public_key      = tls_private_key.ssh.public_key_openssh
}

// create the hub virtual network components
module "vnet-hub" {
  source                = "./modules/vnet-hub"
  resource_group_name   = azurerm_resource_group.rg-hub-vnet.name
  region                = var.region
  private_dns_zone_name = azurerm_private_dns_zone.private-dns-zone.name
  vm_username           = var.vm_username
  ssh_public_key        = tls_private_key.ssh.public_key_openssh
}

// create the application spoke virtual network components
module "vnet-spoke-application" {
  source                = "./modules/vnet-spoke-application"
  resource_group_name   = azurerm_resource_group.rg-application-vnet.name
  region                = var.region
  private_dns_zone_name = azurerm_private_dns_zone.private-dns-zone.name
  vm_username           = var.vm_username
  ssh_public_key        = tls_private_key.ssh.public_key_openssh
}

locals {
  connect_hub = <<-EOT
    #!/bin/bash
    ##
    ## Connect to the hubs VM
    ##
    ssh  ${module.vnet-hub.vm_username}@${module.vnet-hub.vm_public_ip_address} -i ~/.ssh/private_key.pem

  EOT

  connect_spoke = <<-EOT
    #!/bin/bash
    ##
    ## Connect to the spoke VM
    ##
    ssh  ${module.vnet-spoke-application.vm_username}@${module.vnet-spoke-application.vm_public_ip_address} -i ~/.ssh/private_key.pem

  EOT
}

resource "local_file" "output_shell_connect_hub" {
  content  = local.connect_hub
  filename = "${path.module}/connect_hub.sh"
}

resource "local_file" "output_shell_connect_spoke" {
  content  = local.connect_spoke
  filename = "${path.module}/connect_spoke.sh"
}

/*
// create an output file to connect to the HUB VM's
resource "local_file" "connect-hubvm" {
  content  = <<EOF
  Line 1: "#!/bin/bash"
  Line 2: "ssh  ${output.hub_vm_user_name.value}@${output.hub_vm_public_ip_address.value} -i ~/.ssh/private_key.pem"
  EOF
 
  filename = "${path.module}/connect_hubvm.sh"
}

*/
// create an output file to connect to the Spoke VM's
/*resource "local_file" "connect-spokevm" {
  content  = <<EOF
  #!/bin/bash
  ssh  ${output.spoke_vm_user_name}@${output.spoke_vm_public_ip_address} -i ~/.ssh/private_key.pem
  EOF
 
  filename = "${path.module}/connect_spokevm.sh"
}
*/



