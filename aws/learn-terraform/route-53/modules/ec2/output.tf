# VPC to put the EC2
output "vpc_id" {
  value = data.aws_vpc.default.id
}

# Subnet to put the EC2
output "subnet_id" {
  value = data.aws_subnets.subnets.ids[0]
}

# Public IP of the EC2
output "public_ip" {
  value = aws_instance.websrv_one.public_ip
}

/*
output "subnet_ids" {
  value = data.aws_subnets.subnets.ids
}
*/