/*
    The terraform will
    Create 2 EC2 instances with web servers in two regions
    Register their public IP addresses on Route53

*/
# Define the AWS provider with aliases for each region
provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}

provider "aws" {
  alias  = "us_west_2"
  region = "us-west-2"
}


locals {
  hostedzone_name = "tribeoffive.info." # My existing Route 53 Hosted Zone. 
}

module "ec2_us_east_2" {
  providers = {
    aws.alternative = aws.us_east_2
  }
  ssh_key_name  = aws_key_pair.ssh-public-key.key_name
  source          = "./modules/ec2"
}


/*
module "ec2_us_west_2" {
  providers = {
    aws.alternative = aws.us_west_2
  }
  ssh_public_key  = tls_private_key.ssh.public_key_openssh 
  source          = "./modules/ec2"
}
*/

# Load my existing hosted zone
data "aws_route53_zone" "selected" {
  name         = local.hostedzone_name
  private_zone = false
}


# Create a Hosted Zone record for my useast2_websrv
resource "aws_route53_record" "useast2_websrv" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "useast2.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = [module.ec2_us_east_2.public_ip]
}

/*
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id 
  name    = "dev.${data.aws_route53_zone.selected.name}"
  type    = "A"
  alias {
    name                   = var.alb_dns
    zone_id                = var.zone_id
    evaluate_target_health = false
  }
}
*/


