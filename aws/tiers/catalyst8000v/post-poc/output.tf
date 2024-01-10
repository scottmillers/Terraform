output "controller_eip" {
  value       = data.aws_eip.controller_vpn0.public_ip
}

output "node_eip" {
  value       = data.aws_eip.node_vpn0.public_ip
}

output "webserver_eip" {
  value       = data.aws_eip.webserver_vpn0.public_ip
}


output "public_key_name" {
  value       = data.aws_key_pair.public_key.key_name
}