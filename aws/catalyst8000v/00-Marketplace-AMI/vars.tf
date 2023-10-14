variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_ami_id_branch1_r1" {
  default = "ami-0c1961e24860d740c"   # Cisco-CSR-SDWAN-17.3.2 Marketplace AMI for this region. Please change the AMI if you want to use a different region!
}

variable "aws_ami_type_branch1_r1" {
  default = "c5.xlarge"               # please keep in mind, that your AWS instance type needs to support at least 3 NICs.  
}



