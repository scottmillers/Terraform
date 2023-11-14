

output "public_ip" {
  value = aws_instance.web_server_one.public_ip
}

/*
output "latest_al2023_ami" {
  description = "The latest Linux 2023"
  value       = data.aws_ami.latest_al2023_ami.id
}



output "latest_amzn2_ami" {
  description = "The latest Linux 2"
  value       = data.aws_ami.latest_amzn2_ami.id
}
*/
