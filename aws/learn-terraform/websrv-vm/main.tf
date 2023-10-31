terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

provider "aws" {
  region = var.region
}



# See https://registry.terraform.io/modules/cloudposse/label/null/latest for documentation
module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  # insert the 12 required variables here
  namespace  = "example"
  stage      = "dev"
  name       = "learning-terraform"
  attributes = ["public"]
  delimiter  = "-"

  tags = {
    "BusinessUnit" = "CTO",
    "Snapshot"     = "true"
  }
}



# Setup the network

module "my_vpc" {
  source     = "./modules/vpc"
  subnet1_az = var.subnet1_az
}

# Build the web server
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amzn2_x86_ami.id
  instance_type          = var.instance_type
  user_data              = file("scripts/init-script-ngx.sh")
  vpc_security_group_ids = [module.my_vpc.public_subnet1_sg_id]
  subnet_id              = module.my_vpc.public_subnet1_id
  tags = module.label.tags
}

