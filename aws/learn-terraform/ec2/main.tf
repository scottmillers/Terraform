/*
    Create a EC2 that has a simple web server in a availability zone

        Uses the Terraform VPC Module
        https://github.com/terraform-aws-modules/terraform-aws-vpc

        Terraform VPC how to use
        https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete/main.tf

*/
provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "us-east-2"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  instance_type = "t2.micro"
  ec2_login     = "ec2"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name
  cidr = local.vpc_cidr

  #azs             = ["us-east-2a", "us-east-2b"]
  azs = local.azs
  #private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  #public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]

  manage_default_security_group = false
  manage_default_network_acl =  false
  manage_default_route_table = false
  #default_security_group_name = "my-default-security-group" # VPC module creates another default security group. I already have one
  enable_nat_gateway          = true
  single_nat_gateway          = true

  tags = local.tags

}


# Create a security group for my web serversyes
resource "aws_security_group" "web_srv_sg" {
  vpc_id = module.vpc.vpc_id
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



# Create the first web server
resource "aws_instance" "web_server_one" {
  ami                         = data.aws_ami.latest_amzn2_ami.id
  instance_type               = local.instance_type
  user_data                   = file("scripts/ec2-user-data.sh")
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.web_srv_sg.id]
  key_name = aws_key_pair.ssh-public-key.key_name

}

