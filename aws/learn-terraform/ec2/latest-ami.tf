# This module helps with find the latest AMI for Amazon Linux 2, Amazon Linux 2023, and Ubuntu Jammy Jellyfish 
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
# Uncomment out the id from the output statement to get the full details on the AMI

# Amazon Linux 2
# ARM
data "aws_ami" "latest_amzn2_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"] # this kernel is shown in the quickstart
    #values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "architecture"
    #values = ["arm64"]
    values = ["x86_64"]
  }
}


# Amazon Linux 2023
data "aws_ami" "latest_al2023_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*"] # this kernel is shown in the quickstart
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "architecture"
    #values = ["arm64"]
    values = ["x86_64"]
  }
}





# For Ubuntu
#https://cloud-images.ubuntu.com/locator/ec2/
# Find the latest AMI for Ubuntu Jammy Jellyfish
/*
data "aws_ami" "latest_ubuntu_ami" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name   = "architecture"
        values = ["amd64"]
    }

    owners = ["099720109477"] # Canonical
}


output "ubuntu_amd_ami_id" {
  description = "The AMI ID for latest Ubuntu 22.04 (AMD)"
  value       = data.aws_ami.latest_ubuntu_ami.id
}
*/








# Get the latest from System Service Manager
/* This works but you cant show the value
data "aws_ssm_parameter" "latest_amzn2_x86_ami" {  
   name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-kernel-5.10-hvm-x86_64-gp2"
}
# Get the lastest from System Service Manager
data "aws_ssm_parameter" "latest_amzn2_arm_ami" {  
   name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-kernel-5.10-hvm-arm64-gp2"
}
*/