# create a tls_private_key resource using the ED25519 algorithm since that is recommended by Cisco documentation
resource "tls_private_key" "ssh" {
  algorithm = "ED25519"
}

resource "local_sensitive_file" "public-key-pem-file" {
  //filename = pathexpand("~/.ssh/${local.ssh_key_name}.pem")
  //filename             = pathexpand("~/.ssh/public_key.pem")
  filename             = "./scripts/public_key.pem"
  file_permission      = "600"
  content              = tls_private_key.ssh.public_key_openssh
}

resource "local_sensitive_file" "private-key-pem-file" {
  //filename = pathexpand("~/.ssh/${local.ssh_key_name}.pem")
  //filename             = pathexpand("~/.ssh/private_key.pem")
  filename             = "./scripts/private_key.pem"
  file_permission      = "600"
  content              = tls_private_key.ssh.private_key_openssh
}

# Put the public key on AWS
resource "aws_key_pair" "public_key" {
  key_name   = var.aws_key_pair_name
  public_key = tls_private_key.ssh.public_key_openssh
}

