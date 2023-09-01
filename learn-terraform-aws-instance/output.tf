output "web_server_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "domain-name" {
  value = aws_instance.web_server.public_dns
}

output "application-url" {
  value = "${aws_instance.web_server.public_dns}/index.php"
}
/*

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

*/