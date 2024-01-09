variable "aws_profile" {
  description = "AWS CLI Profile to use"
  type        = string
  default     = "tiers"
}

variable "aws_region" {
  default = "us-east-2"
}


variable "aws_az1" {
  default = "us-east-2a"
}



variable "network_vpc_cidr" {
  default = "100.101.0.0/24" #256 addresses for the network
}

variable "network_subneta_cidr" {
  default = "100.101.0.0/25" # 128 ip addresses. Range is 100.101.0.0 to 100.101.0.127
}

variable "network_subnetb_cidr" {
  default = "100.101.0.128/25" # 128 ip addresses. Range is 100.101.0.129 to 100.101.0.254
}


variable "production_vpc_cidr" {
  default = "10.0.0.0/24" #256 addresses for the production
}

variable "production_subneta_cidr" {
  default = "10.0.0.0/25"
}

variable "production_subnetb_cidr" {
  default = "10.0.0.128/25"
}


variable "bucket_prefix" { # use this a prefix in descriptions of resources, which will be prepended to the name of all ressources. Example "Demo Branch1 Subnet-1 Mgmt"
  default = "Test"
}

// the public key for the controller instance
variable "aws_key_pair_name" {
  default = "my-key-pair" # Public key for EC2 instance
}

variable "ec2_username" {
  default = "ec2-user" # Default EC2 username for SSH
}


variable "aws_ami_id_awslinux2023" {
  default = "ami-0ee4f2271a4df2d7d" # AWS Linux 2023 in us-east-2 
}
variable "aws_ami_id_cisco8000v_byol" {
  default = "ami-073d0f81e96822a78" # Cisco-C8K-17.13.01a in us-east-2
}

#variable aws_ami_id_cisco8000vbyol {
# default = "ami-0f1ab0f93d85e0877"  # Cisco-C8K-17.13.01a in us-east-1
#}

######################################
# Network VPC EC2's
######################################
variable "controller_vpn0_privateip_address" {
  default = "100.101.0.4"
}

variable "controller_vpn1_privateip_address" {
  default = "100.101.0.5"
}

variable "controller_vpn30_privateip_address" {
  default = "100.101.0.6"
}


variable "controller_sci_privateip_address" {
  default = "100.101.0.7"
}

variable "controller_instance_type" {
  default = "t3.medium"
}



######################################
# Network VPC Security Groups
######################################
variable "ssh_allow_cidr" { # allow ssh from anywhere. needs to be modified!
  default = "0.0.0.0/0"
}

variable "https_allow_cidr" { # allow https from anywhere.  needs to be modified!
  default = "0.0.0.0/0"
}


######################################
# Production VPC EC2's
######################################
variable "webserver_vpn0_privateip_address" {
  default = "10.0.0.4"
}

variable "webserver_vpn1_privateip_address" {
  default = "10.0.0.5"
}

variable "webserver_instance_type" {
  default = "t3.medium"
}





