output "kms_key_alias" {
  description = "The alias of the KMS key"
  value       = aws_kms_alias.my_kms_alias.name
}
