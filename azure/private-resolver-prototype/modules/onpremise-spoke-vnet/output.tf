output "dns_public_ip_address" {
  value = azurerm_windows_virtual_machine.dns-onprem.public_ip_address
}

output "dns_admin_username" {
  sensitive = false
  value     = azurerm_windows_virtual_machine.dns-onprem.admin_username
}

output "dns_admin_password" {
  sensitive = true
  value     = azurerm_windows_virtual_machine.dns-onprem.admin_password
}

