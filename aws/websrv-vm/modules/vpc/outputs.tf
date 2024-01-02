output "public_subnet1_id" {
  description = "The id of the public subnet"
  value       = aws_subnet.example_public_subnet1.id
}

output "public_subnet1_sg_id" {
  description = "The id of the security group attached to the public subnet"
  value       = aws_security_group.example_web_sg.id
}