
resource "aws_vpc" "network_vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

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
resource "aws_security_group" "example_web_sg" {
  vpc_id = aws_vpc.example_vpc.id
  name = "example-publicsubnet-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: This allows HTTP from anywhere. Modify as needed.
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # WARNING: This allows SSH from anywhere. Modify as needed.
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
