# foo/main.tf
resource "local_file" "file" {
  content  = var.content
  filename = "${path.module}/hi.txt"
}

variable "content" {}