# Create SD-WAN Router in the Branch:

resource "aws_instance" "branch1_r1" {
  ami 				= var.aws_ami_id_branch1_r1
  instance_type 	= var.aws_ami_type_branch1_r1
  key_name 			= var.aws_key_pair_name
  availability_zone = var.aws_branch1_az
  user_data  		= file("cloud-init-branch1-r1.user_data")

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.branch1_r1_nic1.id
    delete_on_termination = false
  }

  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.branch1_r1_nic2.id
    delete_on_termination = false
  }
  
  network_interface {
    device_index         = 2
    network_interface_id = aws_network_interface.branch1_r1_nic3.id
    delete_on_termination = false
  }

  tags = {
    Name = "${var.bucket_prefix} Branch1 SD-WAN R1"
  }

}