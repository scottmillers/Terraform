# Create Controller VMs:


# Create VPN0-WAN NIC
resource "aws_network_interface" "controller_vpn0" {
  subnet_id         = aws_subnet.network_subneta.id
  private_ips       = [var.controller_vpn0_privateip_address]
  security_groups   = [aws_security_group.cisco8000v_sg.id]
  source_dest_check = false
  description       = "${var.bucket_prefix} VPN0"
  tags = {
    Name = "${var.bucket_prefix} VPN0"
  }
}


# Attach an elastic ip to the interface
resource "aws_eip" "controller_vpn0" {
  network_interface = aws_network_interface.controller_vpn0.id
  tags = {
    Name = "${var.bucket_prefix} VPN0 Elastic IP"
  }
}




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


  tags = {
    Name = "${var.bucket_prefix} Catalyst 8000V Controller"
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