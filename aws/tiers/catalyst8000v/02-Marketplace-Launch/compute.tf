# Create Controller VMs:

# Create NICs:

resource "aws_network_interface" "sdwan_nic1" {
  subnet_id          = aws_subnet.controllers_subnet1.id
  private_ips        = [var.aws_sdwan_subnet1_private_ip]
  security_groups    = [aws_security_group.controllers_vpn512_sg.id]
  source_dest_check  = false
  description = "${var.bucket_prefix} SDWAN-NIC1-VPN512"
  tags  = {
    Name             = "${var.bucket_prefix} SDWAN-NIC1-VPN512"
  }
}


resource "aws_instance" "controller_sdwan" {
  ami                = var.aws_ami_id_cisco8000vbyol
  instance_type      = var.aws_ami_type_sdwan
  key_name           = var.aws_key_pair_name
  availability_zone  = var.aws_controllers_az

  network_interface {
    device_index            = 0
    network_interface_id    = aws_network_interface.sdwan_nic1.id
    delete_on_termination   = false 
  }
/*
  network_interface {
    device_index            = 1
    network_interface_id    = aws_network_interface.vmanage_nic2.id
    delete_on_termination   = false
  }
*/
  tags  = {
    Name             = "${var.bucket_prefix} Catalyst 8000V"
  }
}
