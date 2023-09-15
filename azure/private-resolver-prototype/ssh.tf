# create a tls_private_key resource
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

/*
resource "local_file" "private_key_file" {
  filename = "~/.ssh/private_key.pem"  # Adjust the filename as needed
  content  = tls_private_key.ssh.private_key_pem
}

resource "local_file" "public_key_file" {
  filename = "~/.ssh/public_key.pub"  # Adjust the filename as needed
  content  = tls_private_key.ssh.public_key_openssh
}
*/

resource "local_sensitive_file" "pem_file" {
  //filename = pathexpand("~/.ssh/${local.ssh_key_name}.pem")
  filename = pathexpand("~/.ssh/private_key.pem")
  file_permission = "600"
  directory_permission = "700"
  content = tls_private_key.ssh.private_key_pem
}