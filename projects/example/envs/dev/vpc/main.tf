provider "aws" {
  region = var.region
}

module "vpc" {
    region = var.region
    profile = "sandbox"
    source = "../../../modules/vpc"
    environment = "dev"
    cidr_block = "10.0.0.0/16"
}