

resource "aws_vpc" "example_vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "example-vpc"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "example_gw" {
  vpc_id = aws_vpc.example_vpc.id
}

# Create a public subnet
resource "aws_subnet" "example_public_subnet1" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.subnet1_az
  map_public_ip_on_launch = true  # Auto-assign public IPs to instances in this subnet
  tags = {
    Name = "example-public-subnet-1"
  }
}

# Create a public route table
resource "aws_route_table" "example_public_route_table" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_gw.id
  }
}

# Create a security group for the public network
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.example_vpc.id
  name = "example-publicsubnet-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.example_public_subnet1.id 
  route_table_id = aws_route_table.example_public_route_table.id
}


# Create a private subnet
resource "aws_subnet" "example_private_subnet1" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.subnet2_az

  tags = {
    Name = "example-private-subnet-1"
  }
}

