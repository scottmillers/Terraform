terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

provider "random" {}

resource "random_pet" "name" {}

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

module "my_vpc" {
  source     = "./modules/vpc"
  subnet1_az = "us-west-2a"
  subnet2_az = "us-west-2b"
  // other needed variables here
}




resource "aws_instance" "web_server" {
  ami                    = "ami-a0cfeed8"
  instance_type          = "t2.micro"
  user_data              = file("init-script.sh")
  vpc_security_group_ids = [module.my_vpc.public_subnet1_sg_id]
  subnet_id              = module.my_vpc.public_subnet1_id
  tags = module.label.tags
  /*tags = {
    Name = random_pet.name.id
  }
  */
}