# Create Controller VMs:

# Create NICs:
resource "aws_network_interface" "cisco8000v_controller_nic1" {
  subnet_id         = aws_subnet.cisco8000v_subnet1.id
  private_ips       = [var.cisco8000v_controller_nic1_ip_address]
  security_groups   = [aws_security_group.cisco8000v_sg.id]
  source_dest_check = false
  description       = "${var.bucket_prefix} Controller-WAN0"
  tags = {
    Name = "${var.bucket_prefix} Controller-WAN0"
  }
}


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
  /*
  network_interface {
    device_index            = 1
    network_interface_id    = aws_network_interface.vmanage_nic2.id
    delete_on_termination   = false
  }
*/
  tags = {
    Name = "${var.bucket_prefix} Catalyst 8000V"
  }
}
