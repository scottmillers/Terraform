# This module helps with find the latest AMI for Amazon Linux 2, Amazon Linux 2023, and Ubuntu Jammy Jellyfish 
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html

# Amazon Linux 2
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/amazon-linux-2-virtual-machine.html
data "aws_ami" "amzn2_arm_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  } 
}

/*
output "amzn2_arm_ami_id" {
  description = "The AMI ID for latest Amazon Linux 2 (ARM)"
  value       = data.aws_ami.amzn2_arm_ami.id
}
*/

data "aws_ami" "amzn2_x86_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  } 
}

/*
output "amzn2_x86_ami_id" {
  description = "The AMI ID for latest Amazon Linux 2 (x86)"
  value       = data.aws_ami.amzn2_x86_ami.id
}
*/

# Amazon Linux2023
# https://docs.aws.amazon.com/linux/al2023/ug/ec2.html
# For ARM architectures
/*
data "aws_ami" "amzn2023_arm_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-kernel-6.1-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  } 
}

output "amzn2023_arm_ami_id" {
  description = "The AMI ID for latest Amazon Linux 2023 (ARM)"
  value       = data.aws_ami.amzn2023_arm_ami.id
}
*/
/*
data "aws_ami" "amzn2023_x86_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-kernel-6*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  } 
}


output "amzn2023_x86_ami_id" {
  description = "The AMI ID for latest Amazon Linux 2023 (x86)"
  value       = data.aws_ami.amzn2023_x86_ami.id
}

*/

# For Ubuntu
#https://cloud-images.ubuntu.com/locator/ec2/
# Find the latest AMI for Ubuntu Jammy Jellyfish
data "aws_ami" "ubuntu_arm_ami" {
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
        values = ["arm64"]
    }

    owners = ["099720109477"] # Canonical
}

/*
output "ubuntu_arm_ami_id" {
  description = "The AMI ID for latest Ubuntu 22.04 (ARM)"
  value       = data.aws_ami.ubuntu_arm_ami.id
}
*/


/*
data "aws_ami" "ubuntu_amd_ami" {
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
  value       = data.aws_ami.ubuntu_amd_ami.id
}
*/