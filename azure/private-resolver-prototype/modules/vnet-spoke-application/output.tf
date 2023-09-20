output "vnet_id" {
  value = azurerm_virtual_network.vnet-spoke-application.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet-spoke-application.name
}

output "vm_public_ip_address" {
  value=data.azurerm_public_ip.public-ip-vm-one.ip_address
}

output "vm_username" {
  sensitive = false
  value     = var.vm_username
}





