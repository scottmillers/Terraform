variable "aws_profile" {
  description = "AWS CLI Profile to use"
  type        = string
  default     = "tiers"
}

variable "aws_region" {
  default = "us-east-2"
}


variable "controller_eip_tag" {
  default = "Controller VPN0 Elastic IP"
}


variable "node_eip_tag" {
  default = "Node VPN0 Elastic IP"
}


variable "webserver_eip_tag" {
  default = "WebServer VPN0 Elastic IP"
}

// the public key for all instances
variable "aws_key_pair_name" {
  default = "poc-key-pair" # Public key for EC2 instances
}