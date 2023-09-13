output "dns_public_ip_address" {
  value = azurerm_windows_virtual_machine.dns-onprem.public_ip_address
}

output "dns_admin_username" {
  sensitive = false
  value     = var.dns_admin_username
}

output "dns_admin_password" {
  sensitive = true
  value     = var.dns_admin_password
}

