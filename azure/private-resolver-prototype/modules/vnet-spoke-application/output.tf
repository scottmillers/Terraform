output "vnet_id" {
  value = azurerm_virtual_network.vnet-spoke-application.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet-spoke-application.name
}

output "vm_public_ip_address" {
  value = azurerm_linux_virtual_machine.vm-one.public_ip_address
}

output "vm_username" {
  sensitive = false
  value     = var.vm_username
}





