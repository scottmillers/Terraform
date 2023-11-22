/*
    The terraform will
    Create 2 EC2 instances with web servers in two regions
    Register their public IP addresses on Route53

*/
# Define the AWS provider with aliases for each region
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}

provider "aws" {
  alias  = "us_west_2"
  region = "us-west-2"
}


# Define a list of regions
locals {
  regions       = ["us-east-2", "us-west-2"] # Add more regions as needed
  instance_type = "t2.micro"
}


module "ec2_us_east_1" {
  providers = {
    aws = aws.us_east_2
  }
  source = "./modules/ec2"
}

/*
module "us_east_1" {
  providers = {
    aws = aws.us_east_1
  }
  vpc_id = "vpc-12345678"  # Replace with the actual VPC ID
  subnet_id = "subnet-12345678"  # Replace with the actual subnet ID
  source = "modules/ec2"
  ami_id = "ami-12345678"  # Replace with the actual AMI ID
  public_key_name = "my-key"  # Replace with the actual public key name
  
}
*/
/*
data "aws_vpc" "default" {
  default  = true
  subnet_id       = "subnet-12345678"  # Replace with the actual subnet ID
}
/*
data "aws_vpc" "default" {
  default = true
  provider = aws.us_west_2
}
*/

/*data "aws_vpc" "default" {
  for_each = { for region in local.regions : region => region }
  provider = aws.${each.key}"
  default  = true
}

# Output the default VPC ID for each region
output "default_vpc_ids" {
  value = { for region in local.regions : region => data.aws_vpc.default[region].id }
}
*/
/*
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  provider = aws.us_west_2
}


output "vpc_id" {
  value = data.aws_vpc.default.id
}
output "subnet_ids" {
  value = data.aws_subnets.subnets.ids
}
*/






/*
resource "aws_route53_zone" "example" {
  name = "example.com"
}

resource "aws_route53_record" "example" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "myec2instance.example.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.example.public_ip]
}
*/

