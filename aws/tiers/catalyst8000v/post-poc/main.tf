provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  # Make it faster by skipping something
  #skip_metadata_api_check     = true
  #skip_region_validation      = true
  #skip_credentials_validation = true

}




######################################
# Elastic IPs
######################################


data "aws_eip" "controller_vpn0" {
  filter {
    name   = "tag:Name"
    values = [var.controller_eip_tag]
  }
}



data "aws_eip" "node_vpn0" {
  filter {
    name   = "tag:Name"
    values = [var.node_eip_tag]
  }
}


data "aws_eip" "webserver_vpn0" {
  filter {
    name   = "tag:Name"
    values = [var.webserver_eip_tag]
  }
}

######################################
# Public Key
######################################
data "aws_key_pair" "public_key" {
  key_name = var.aws_key_pair_name
}

