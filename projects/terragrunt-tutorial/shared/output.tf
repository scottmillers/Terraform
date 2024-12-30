# shared/output.tf
output "content" {
  value = local_file.file.content
}