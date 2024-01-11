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

variable "bucket_prefix" { # use this a prefix in descriptions of resources, which will be prepended to the name of all ressources. Example "Demo Branch1 Subnet-1 Mgmt"
  default = "POC"
}


// the public key for all instances
variable "aws_key_pair_name" {
  default = "poc-key-pair" # Public key for EC2 instances
}

// the username for ssh scripts
variable "ec2_username" {
  default = "ec2-user" # Default EC2 username for SSH
}

######################################
# Elastic IP lookup tags
######################################


// used to lookup the existing EIP
variable "controller_eip_tag" {
  default = "Controller VPN0 Elastic IP"
}

// used to lookup the existing EIP
variable "node_eip_tag" {
  default = "Node VPN0 Elastic IP"
}

// used to lookup the existing EIP
variable "webserver_eip_tag" {
  default = "WebServer VPN0 Elastic IP"
}

######################################
# VPC and Subnet CIDRs
######################################


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



######################################
# AMI's
######################################


variable "aws_ami_id_awslinux2" {
  default = "ami-011ab7c70f5b5170a" # Amazon Linux 2 Kernel 5.10 AMI 2.0.20231218.0 x86_64 HVM gp2 in us-east-2
}
variable "aws_ami_id_cisco8000v_byol" {
  default = "ami-073d0f81e96822a78" # Cisco-C8K-17.13.01a in us-east-2
}

variable "controller_instance_ami" {
  default = "ami-073d0f81e96822a78"
}

variable "node_instance_ami" {
  default = "ami-073d0f81e96822a78"
}

variable "webserver_instance_ami" {
  default = "ami-011ab7c70f5b5170a"
}


#variable aws_ami_id_cisco8000vbyol {
# default = "ami-0f1ab0f93d85e0877"  # Cisco-C8K-17.13.01a in us-east-1
#}


######################################
# Instance Size and Storage
######################################

variable "controller_instance_type" {
  default = "c5n.large"
}

variable "node_instance_type" {
  default = "c5n.large"
}

variable "webserver_instance_type" {
  default = "t3.medium"
}

variable "controller_ebs_size" {
  default = 2048  # 2TB
}

variable "node_ebs_size" {
  default = 2048 # 2TB
}


######################################
# Cisco8000v Controller addresses
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



######################################
# Cisco8000v Node addresses
######################################
variable "node_vpn0_privateip_address" {
  default = "100.101.0.10"
}

variable "node_sci_privateip_address" {
  default = "100.101.0.11"
}



######################################
# Network VPC Security Groups
######################################
variable "vpn0_ssh_allow_cidr" { # allow ssh from anywhere. needs to be modified!
  default = "0.0.0.0/0"
}

variable "vpn0_http_allow_cidr" { # allow https from anywhere.  only for web server. needs to be modified!
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







