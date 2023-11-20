data "aws_vpc" "default" {
  default = true

}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


output "vpc_id" {
  value = data.aws_vpc.default.id
}
output "subnet_ids" {
  value = data.aws_subnets.subnets.ids
}

/*
# Create a security group for my web serversyes
resource "aws_security_group" "web_srv_sg" {
  vpc_id = var.vpc_id
  name   = "websrvsg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: This allows HTTP from anywhere. Modify as needed.
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: This allows SSH from anywhere. Modify as needed.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# Create a web server
resource "aws_instance" "web_server_one" {
  ami                         = data.aws_ami.latest_amzn2_ami.id
  instance_type               = var.instance_type
  user_data                   = file("scripts/ec2-user-data.sh")
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_srv_sg.id]
  key_name                    = aws_key_pair.ssh-public-key.key_name

}
*/