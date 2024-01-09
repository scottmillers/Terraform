




######################################
# Network VPC EC2's
######################################

# Create the Controller VPN0 NIC WAN Internet facing
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


# Create the Controller VPN1 NIC card to connect to the internal TIERS web server
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

# Attach an Controller Elastic IP for VPN0-WAN NIC
resource "aws_eip" "controller_vpn0" {
  network_interface = aws_network_interface.controller_vpn0.id
  tags = {
    Name = "${var.bucket_prefix} Controller VPN0 Elastic IP"
  }
}



# Create the Cisco Controller instance
resource "aws_instance" "controller" {
  ami               = var.aws_ami_id_awslinux2023
  instance_type     = var.controller_instance_type
  key_name          = var.aws_key_pair_name
  availability_zone = var.aws_az1

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


  tags = {
    Name = "${var.bucket_prefix} Catalyst 8000V Controller"
  }
}


########################################
# Production VPC EC2's
########################################
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



# Attach an Webserver Elastic IP for VPN0-WAN NIC
resource "aws_eip" "webserver_vpn0" {
  network_interface = aws_network_interface.webserver_vpn0.id
  tags = {
    Name = "${var.bucket_prefix} WebServer VPN0 Elastic IP"
  }
}
# Create the Production Web Server
resource "aws_instance" "webserver" {
  ami               = var.aws_ami_id_awslinux2023
  instance_type     = var.webserver_instance_type
  key_name          = var.aws_key_pair_name
  availability_zone = var.aws_az1
  user_data                   = file("scripts/user-data-webserver.sh")
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