
// Create the VPC for the Cisco SD-WAN
resource "aws_vpc" "vpc_cisco8000v" {
  cidr_block           = var.aws_vpc_cisco8000v_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.bucket_prefix} Cisco8000v VPC"
  }
}



# Create a Subnets for the Cisco8000V controller and node
resource "aws_subnet" "cisco8000v_subnet1" {
  vpc_id                  = aws_vpc.vpc_cisco8000v.id
  cidr_block              = var.aws_cisco8000v_subnet1_cidr
  availability_zone       = var.aws_az1
  map_public_ip_on_launch = true # Auto-assign public IPs to instances in this subnet
  tags = {
    Name = "${var.bucket_prefix} Cisco8000V Subnet1"
  }
}

/*
resource "aws_subnet" "controllers_subnet2" {
    vpc_id                    = aws_vpc.vpc_controllers.id
    cidr_block                = var.aws_controllers_subnet2_cidr
    availability_zone         = var.aws_controllers_az
    tags = {
        Name                  = "${var.bucket_prefix} SD-WAN-Controllers-Subnet-2-vpn0"
    }
}
*/

# Create IGW for Internet Access:
resource "aws_internet_gateway" "cisco8000v_igw" {
  vpc_id = aws_vpc.vpc_cisco8000v.id
  tags = {
    Name = "${var.bucket_prefix} Cisco8000V-igw"
  }
}


# Create route tables and default route pointing to IGW in VPN512 and VPN0:
resource "aws_route_table" "cisco8000v_rt" {
  vpc_id = aws_vpc.vpc_cisco8000v.id
  route {
    //
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cisco8000v_igw.id
  }

  tags = {
    Name = "${var.bucket_prefix} Cisco8000V-rt"
  }
}

# Create security group:
resource "aws_security_group" "cisco8000v_sg" {
  vpc_id = aws_vpc.vpc_cisco8000v.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    // Change this to restrict SSH 
    cidr_blocks = [var.ssh_allow_cidr]
  }

  //If you do not add this rule, you can not reach the vManage Web Interface  
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    // Change this to restrict HTTP
    cidr_blocks = [var.https_allow_cidr]
  }


  ingress {
    from_port = 830
    to_port   = 830
    protocol  = "tcp"
    // SD-WAN TCP Ports
    cidr_blocks = ["0.0.0.0/0"]
  }

  //SD-WAN tcp ports 
  ingress {
    from_port   = 23456
    to_port     = 24156
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  //SD-WAN udp ports 
  ingress {
    from_port   = 12346
    to_port     = 13046
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # You may need to allow additional IP address like Branch Routers or Controllers IP here

  tags = {
    Name = "${var.bucket_prefix} Cisco8000V-SG"
  }
}

# Associate CRT and Subnet for VPN512 and VPN0:

resource "aws_route_table_association" "cisco8000v_rta_subnet1" {
  subnet_id      = aws_subnet.cisco8000v_subnet1.id
  route_table_id = aws_route_table.cisco8000v_rt.id
}
/*
resource "aws_route_table_association" "controllers_rta_subnet2"{
    subnet_id        = aws_subnet.controllers_subnet2.id
    route_table_id   = aws_route_table.controllers_vpn0_rt.id
}
*/


