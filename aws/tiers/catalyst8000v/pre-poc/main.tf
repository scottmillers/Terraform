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


# Create an Elastic IP for Controller VPN0 
resource "aws_eip" "controller_vpn0" {
  tags = {
    Name = var.controller_eip_tag
  }
}


# Create an Elastic IP for the Node VPN0 
resource "aws_eip" "node_vpn0" {
  tags = {
    Name = var.node_eip_tag
  }
}


# Create an Elastic IP for the WebServer VPN0 
resource "aws_eip" "webserver_vpn0" {
  tags = {
    Name = var.webserver_eip_tag
  }
}
