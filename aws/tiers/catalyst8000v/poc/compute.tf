######################################
# Existing Elastic IP's and Keys
######################################


data "aws_eip" "controller_vpn0" {
  filter {
    name   = "tag:Name"
    values = [var.controller_eip_tag]
  }
}



data "aws_eip" "node_vpn0" {
  filter {
    name   = "tag:Name"
    values = [var.node_eip_tag]
  }
}


data "aws_eip" "webserver_vpn0" {
  filter {
    name   = "tag:Name"
    values = [var.webserver_eip_tag]
  }
}


data "aws_key_pair" "public_key" {
  key_name = var.aws_key_pair_name
}


######################################
# Cisco Catalyst8000V Controller EC2
######################################

# Create the Security group for VPN0
resource "aws_security_group" "controller_vpn0" {
  vpc_id = aws_vpc.network.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1 # means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    // Change this to restrict SSH 
    cidr_blocks = [var.vpn0_ssh_allow_cidr]
  }

  tags = {
    Name = "${var.bucket_prefix} Controller vpn0 Security Group"
  }
}

# Create the Controller VPN0 NIC 
resource "aws_network_interface" "controller_vpn0" {
  subnet_id         = aws_subnet.network_a.id
  private_ips       = [var.controller_vpn0_privateip_address]
  security_groups   = [aws_security_group.controller_vpn0.id]
  source_dest_check = false
  description       = "${var.bucket_prefix} Controller VPN0"
  tags = {
    Name = "${var.bucket_prefix} Controller VPN0"
  }
}

# Associate the existing EIP with the NIC
resource "aws_eip_association" "controller_vpn0_eip_assoc" {
  allocation_id = data.aws_eip.controller_vpn0.id  # 
  network_interface_id = aws_network_interface.controller_vpn0.id   
}


# Create the Security Group for Controller to Web Server 
resource "aws_security_group" "controller_vpn1" {
  vpc_id = aws_vpc.network.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.production_vpc_cidr] ## Allow all traffic to anywhere in the Production VPC
  }

  ingress {
    from_port   = -1 # ICMP does not use a port, so set to -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.production_vpc_cidr] # Allow ping from the Production VPC to test
  }


  tags = {
    Name = "${var.bucket_prefix} Controller VPN1 Security Group"
  }
}

# Create the Controller VPN1 NIC 
resource "aws_network_interface" "controller_vpn1" {
  subnet_id         = aws_subnet.network_a.id
  private_ips       = [var.controller_vpn1_privateip_address]
  security_groups   = [aws_security_group.controller_vpn1.id]
  source_dest_check = false
  description       = "${var.bucket_prefix} Controller VPN1"
  tags = {
    Name = "${var.bucket_prefix} Controller VPN1"
  }
}


# Create the Controller VPN30 NIC 
/*resource "aws_network_interface" "controller_vpn30" {
  subnet_id         = aws_subnet.network_a.id
  private_ips       = [var.controller_vpn30_privateip_address]
  security_groups   = [aws_security_group.controller_vpn1_vpn30.id]
  source_dest_check = false
  description       = "${var.bucket_prefix} Controller VPN30"
  tags = {
    Name = "${var.bucket_prefix} Controller VPN30"
  }
}
*/


# Create the Security group for Controller to/from Node
resource "aws_security_group" "sci" {
  vpc_id = aws_vpc.network.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.network_subneta_cidr]  # Only allow incoming traffic from the subnet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.bucket_prefix} SCI Security Group"
  }
}


# Create the Controller SCI NIC card to connect to the Cisco Catalyst8000V node
resource "aws_network_interface" "controller_sci" {
  subnet_id         = aws_subnet.network_a.id
  private_ips       = [var.controller_sci_privateip_address]
  security_groups   = [aws_security_group.sci.id]
  source_dest_check = false
  description       = "${var.bucket_prefix} Controller SCI"
  tags = {
    Name = "${var.bucket_prefix} Controller SCI"
  }
}



# Create a EBS volume for controller data
resource "aws_ebs_volume" "controller_data" {
  size              = var.controller_ebs_size
  type              = "gp3"
  availability_zone = var.aws_az1
  
  tags = {
    Name = "${var.bucket_prefix} Controller EBS data volume"
  }
}

# Create the Controller instance
resource "aws_instance" "controller" {
  ami               = var.aws_ami_id_awslinux2
  instance_type     = var.controller_instance_type
  key_name          = var.aws_key_pair_name
  availability_zone = var.aws_az1
  user_data         = file("scripts/user_data_mountfs.sh")
  network_interface {
    device_index          = 0
    network_interface_id  = aws_network_interface.controller_vpn0.id
    delete_on_termination = false
  }

  network_interface {
    device_index          = 1
    network_interface_id  = aws_network_interface.controller_vpn1.id
    delete_on_termination = false
  }

  network_interface {
    device_index          = 2
    network_interface_id  = aws_network_interface.controller_sci.id
    delete_on_termination = false
  }

  
  tags = {
    Name = "${var.bucket_prefix} Catalyst 8000V Controller"
  }
}

# Attach the EBS data volume to the Controller
resource "aws_volume_attachment" "controller_ebs_data" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.controller_data.id
  instance_id = aws_instance.controller.id
}

######################################
# Cisco Catalyst8000V Node EC2
######################################


# Create the Security Group for VPN0
resource "aws_security_group" "node_vpn0" {
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
    cidr_blocks = [var.vpn0_ssh_allow_cidr]
  }

  tags = {
    Name = "${var.bucket_prefix} Node vpn0 Security Group"
  }
}

# Create the Node VPN0 NIC WAN Internet facing
resource "aws_network_interface" "node_vpn0" {
  subnet_id         = aws_subnet.network_a.id
  private_ips       = [var.node_vpn0_privateip_address]
  security_groups   = [aws_security_group.node_vpn0.id]
  source_dest_check = false
  description       = "${var.bucket_prefix} Node VPN0"
  tags = {
    Name = "${var.bucket_prefix} Node VPN0"
  }
}


# Associate the existing EIP with the VPN0 NIC
resource "aws_eip_association" "node_vpn0_eip_assoc" {
  allocation_id = data.aws_eip.node_vpn0.id  
  network_interface_id = aws_network_interface.node_vpn0.id
}

# Create the Node interface to the Controller
resource "aws_network_interface" "node_sci" {
  subnet_id         = aws_subnet.network_a.id
  private_ips       = [var.node_sci_privateip_address]
  security_groups   = [aws_security_group.sci.id]
  source_dest_check = false
  description       = "${var.bucket_prefix} Node SCI"
  tags = {
    Name = "${var.bucket_prefix} Node SCI"
  }
}



# Create a EBS volume for node data
resource "aws_ebs_volume" "node_data" {
  size              = var.node_ebs_size
  type              = "gp3"
  availability_zone = var.aws_az1
  
  tags = {
    Name = "${var.bucket_prefix} Node EBS data volume"
  }
}

# Create the Cisco Node instance
resource "aws_instance" "node" {
  ami               = var.aws_ami_id_awslinux2
  instance_type     = var.node_instance_type
  key_name          = var.aws_key_pair_name
  availability_zone = var.aws_az1

  network_interface {
    device_index          = 0
    network_interface_id  = aws_network_interface.node_vpn0.id
    delete_on_termination = false
  }

  network_interface {
    device_index          = 1
    network_interface_id  = aws_network_interface.node_sci.id
    delete_on_termination = false
  }


  tags = {
    Name = "${var.bucket_prefix} Catalyst 8000V Node"
  }
}


# Attach the EBS data volume to the Node
resource "aws_volume_attachment" "node_ebs_data" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.node_data.id
  instance_id = aws_instance.node.id
}


########################################
# Production WebServer EC2
########################################

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
    cidr_blocks = [var.vpn0_ssh_allow_cidr]
  }

   ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    // Change this to restrict SSH 
    cidr_blocks = [var.vpn0_http_allow_cidr]
  }


  tags = {
    Name = "${var.bucket_prefix} WebServer vpn0 Security Group"
  }
}


# Create the Webserver VPN0 NIC WAN Internet facing
resource "aws_network_interface" "webserver_vpn0" {
  subnet_id         = aws_subnet.production_a.id
  private_ips       = [var.webserver_vpn0_privateip_address]
  security_groups   = [aws_security_group.webserver_vpn0.id]
  source_dest_check = false
  description       = "${var.bucket_prefix} WebServer VPN0"
  tags = {
    Name = "${var.bucket_prefix} WebServer VPN0"
  }
}


# Associate the existing EIP with the VPN0 NIC
resource "aws_eip_association" "webserver_vpn0_eip_assoc" {
  allocation_id = data.aws_eip.webserver_vpn0.id
  network_interface_id = aws_network_interface.webserver_vpn0.id
}


resource "aws_security_group" "webserver_vpn1" {
  vpc_id = aws_vpc.production.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.network_vpc_cidr]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [var.network_vpc_cidr] # allow HTTP traffic from the network VPC
  }

  ingress {
    from_port   = -1 # ICMP does not use a port, so set to -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Change this as needed for your security
  }



  tags = {
    Name = "${var.bucket_prefix} WebServer vpn1 Security Group"
  }
}


# Create the Webserver VPN1 NIC card to connect to the internal TIERS web server
resource "aws_network_interface" "webserver_vpn1" {
  subnet_id         = aws_subnet.production_a.id
  private_ips       = [var.webserver_vpn1_privateip_address]
  security_groups   = [aws_security_group.webserver_vpn1.id]
  source_dest_check = false
  description       = "${var.bucket_prefix} VPN1"
  tags = {
    Name = "${var.bucket_prefix} VPN1"
  }
}

# Create the Production Web Server
resource "aws_instance" "webserver" {
  ami               = var.aws_ami_id_awslinux2
  instance_type     = var.webserver_instance_type
  key_name          = var.aws_key_pair_name
  availability_zone = var.aws_az1
  user_data         = file("scripts/user_data_httpd.sh")
  network_interface {
    device_index          = 0
    network_interface_id  = aws_network_interface.webserver_vpn0.id
    delete_on_termination = false
  }

  network_interface {
    device_index          = 1
    network_interface_id  = aws_network_interface.webserver_vpn1.id
    delete_on_termination = false
  }


  tags = {
    Name = "${var.bucket_prefix} Production Web Server"
  }
}


/*
resource "aws_instance" "cisco8000v_controller" {
  ami               = var.aws_ami_id_cisco8000v_byol
  instance_type     = var.aws_instance_type_cisco8000v_controller
  key_name          = var.aws_key_pair_name
  availability_zone = var.aws_az1

  network_interface {
    device_index          = 0
    network_interface_id  = aws_network_interface.cisco8000v_controller_nic1.id
    delete_on_termination = false
  }
 
  network_interface {
    device_index            = 1
    network_interface_id    = aws_network_interface.vmanage_nic2.id
    delete_on_termination   = false
  }

  tags = {
    Name = "${var.bucket_prefix} Catalyst 8000V Controller"
  }
}
*/