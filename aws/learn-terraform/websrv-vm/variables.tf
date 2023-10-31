variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "subnet1_az" {
  description = "Availability zone for subnet 1"
  default     = "us-east-1a"
}

variable "subnet2_az" {
  description = "Availability zone for subnet 1"
  default     = "us-east-1b"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
  
}
