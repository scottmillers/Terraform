provider "aws" {
  region = var.region
}

module "vpc" {
    source = "git@github.com:scottmillers/terraform-aws-example-vpc.git?ref=v0.1.0"
    #  source = "../../../modules/vpc"
    region = var.region
    profile = "sandbox"
    environment = "dev"
    cidr_block = "10.0.0.0/16"
}