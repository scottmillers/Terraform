# create a tls_private_key resource
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "local_sensitive_file" "public-key-pem-file" {
  //filename = pathexpand("~/.ssh/${local.ssh_key_name}.pem")
  //filename             = pathexpand("~/.ssh/public_key.pem")
  filename             = "./scripts/public_key.pem"
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.ssh.public_key_openssh
}

resource "local_sensitive_file" "private-key-pem-file" {
  //filename = pathexpand("~/.ssh/${local.ssh_key_name}.pem")
  //filename             = pathexpand("~/.ssh/private_key.pem")
  filename             = "./scripts/private_key.pem"
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.ssh.private_key_pem
}

resource "aws_key_pair" "ssh-public-key" {
  key_name   = "my-public-key"
  public_key = tls_private_key.ssh.public_key_openssh
  #public_key = file("${path.module}/scripts/public_key.pem")
}