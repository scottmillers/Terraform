
//  Network VPC
resource "aws_vpc" "network" {
  cidr_block           = var.network_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.bucket_prefix} Network VPC"
  }
}

//  Production VPC
resource "aws_vpc" "production" {
  cidr_block           = var.production_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.bucket_prefix} Production VPC"
  }
}



# Subnet A for the Cisco8000V controller and node
resource "aws_subnet" "network_a" {
  vpc_id                  = aws_vpc.network.id
  cidr_block              = var.network_subneta_cidr
  availability_zone       = var.aws_az1
  map_public_ip_on_launch = true # Auto-assign public IPs to instances in this subnet
  tags = {
    Name = "${var.bucket_prefix} Network SubnetA"
  }
}


# Subnet A for the TIERS Production Instances
resource "aws_subnet" "production_a" {
  vpc_id                  = aws_vpc.production.id
  cidr_block              = var.production_subneta_cidr
  availability_zone       = var.aws_az1
  map_public_ip_on_launch = true # Auto-assign public IPs to instances in this subnet
  tags = {
    Name = "${var.bucket_prefix} Production SubnetA"
  }
}


// Transit Gateway between Production and Network
resource "aws_ec2_transit_gateway" "main" {
  description = "Main Transit Gateway"
  tags = {
    Name = "${var.bucket_prefix} Main Transit Gateway"
  }
}

// Attach the Network VPC to the Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attachment_network" {
  subnet_ids         = [aws_subnet.network_a.id] # Replace with your subnet IDs of the Network subnets
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = aws_vpc.network.id # Replace with your Network VPC ID
}

// Attach the Production VPC to the Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attachment_production" {
  subnet_ids         = [aws_subnet.production_a.id] # Replace with your subnet IDs of the Production subnets
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = aws_vpc.production.id # Replace with your Production VPC ID
}

###################
# Internet Gateways
###################

# Create Network VPC Internet Gateway
resource "aws_internet_gateway" "network" {
  vpc_id = aws_vpc.network.id
  tags = {
    Name = "${var.bucket_prefix} Network IGW"
  }
}


# Create Production VPC Internet Gateway
resource "aws_internet_gateway" "production" {
  vpc_id = aws_vpc.production.id
  tags = {
    Name = "${var.bucket_prefix} Production IGW"
  }
}

###################
# Route Tables
###################

# Create Network VPC Route Tables
resource "aws_route_table" "network" {
  vpc_id = aws_vpc.network.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic through internet Gateway
    gateway_id = aws_internet_gateway.network.id
  }

  route {
    cidr_block         = var.production_vpc_cidr
    transit_gateway_id = aws_ec2_transit_gateway.main.id
  }

  tags = {
    Name = "${var.bucket_prefix} Network VPC Route Table"
  }
}

# Associate the Network Route table with the subnets
resource "aws_route_table_association" "network_subneta" {
  subnet_id      = aws_subnet.network_a.id
  route_table_id = aws_route_table.network.id
}


# Create Production VPC Route Tables
resource "aws_route_table" "production" {
  vpc_id = aws_vpc.production.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic through internet Gateway
    gateway_id = aws_internet_gateway.production.id
  }

  route {
    cidr_block         = var.network_vpc_cidr
    transit_gateway_id = aws_ec2_transit_gateway.main.id
  }

  tags = {
    Name = "${var.bucket_prefix} Production VPC Route Table"
  }
}

# Associate the Production Route table with the subnets
resource "aws_route_table_association" "production_subneta" {
  subnet_id      = aws_subnet.production_a.id
  route_table_id = aws_route_table.production.id
}


###################
# Security Groups
###################

resource "aws_security_group" "controller_vpn0" {
  vpc_id = aws_vpc.network.id

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
  
  tags = {
    Name = "${var.bucket_prefix} Controller vpn0 Security Group"
  }
}


resource "aws_security_group" "controller_vpn1" {
  vpc_id = aws_vpc.network.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1 # ICMP does not use a port, so set to -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Change this as needed for your security
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    // Change this to restrict SSH 
    cidr_blocks = [var.ssh_allow_cidr]
  }

  
  tags = {
    Name = "${var.bucket_prefix} Controller vpn1 Security Group"
  }
}


resource "aws_security_group" "webserver_vpn0" {
  vpc_id = aws_vpc.production.id

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
  
  tags = {
    Name = "${var.bucket_prefix} WebServer vpn0 Security Group"
  }
}


resource "aws_security_group" "webserver_vpn1" {
  vpc_id = aws_vpc.production.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1 # ICMP does not use a port, so set to -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Change this as needed for your security
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    // Change this to restrict SSH 
    cidr_blocks = [var.ssh_allow_cidr]
  }

  tags = {
    Name = "${var.bucket_prefix} WebServer vpn1 Security Group"
  }
}



# Create security group:
/*resource "aws_security_group" "vpn0_sg" {
  vpc_id = aws_vpc.network.id

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
    Name = "${var.bucket_prefix} Controller VPN0 SG"
  }
}
*/


