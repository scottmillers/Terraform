/*
output "dns_public_ip_address" {
  description = "The public ip address of the dns server"
  value       = module.onpremise-spoke-vnet.dns_public_ip_address
}

output "dns_admin_username" {
  description = "The admin username of the dns server"
  sensitive   = false
  value       = module.onpremise-spoke-vnet.dns_admin_username
}

output "dns_admin_password" {
  description = "The admin password of the dns server"
  sensitive   = true
  value       = module.onpremise-spoke-vnet.dns_admin_password
}
*/
