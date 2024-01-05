variable "aws_profile" {
  description = "AWS CLI Profile to use"
  type        = string
  default     = "tiers"
}

variable "aws_region" {
  default = "us-east-2"
}


variable "aws_vpc_cisco8000v_cidr" {
  default = "10.0.0.0/16"
}

variable "aws_cisco8000v_subnet1_cidr" {
  default = "10.0.1.0/24"
}

variable "aws_az1" {
  default = "us-east-2a"
}



variable "aws_tiers_subnet_cidr" {
  default = "10.0.2.0/24"
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


#variable aws_ami_id_cisco8000vbyol {
# default = "ami-0f1ab0f93d85e0877"  # Cisco-C8K-17.13.01a in us-east-1
#}

variable "aws_ami_id_cisco8000v_byol" {
  default = "ami-073d0f81e96822a78" # Cisco-C8K-17.13.01a in us-east-2
}


variable "aws_instance_type_cisco8000v_controller" {
  default = "t3.medium"
}


variable "cisco8000v_controller_nic1_ip_address" {
  default = "10.0.1.11"
}

variable "aws_instance_type_cisco8000v_node" {
  default = "t3.medium"
}


variable "aws_ami_id_awslinux2023" {
  default = "ami-0ee4f2271a4df2d7d" # AWS Linux for the TIERS web server
}


#variable  "aws_sdwan_subnet2_private_ip" {
#  default = "10.0.2.11"
#}

variable "ssh_allow_cidr" { # allow ssh from anywhere. needs to be modified!
  default = "0.0.0.0/0"
}

variable "https_allow_cidr" { # allow https from anywhere.  needs to be modified!
  default = "0.0.0.0/0"
}






