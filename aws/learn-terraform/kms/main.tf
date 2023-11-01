# Create a KMS key
resource "aws_kms_key" "my_kms_key" {
  description = "Key for EBS encryption"
  key_usage = "ENCRYPT_DECRYPT" # this is the default
  customer_master_key_spec = "SYMMETRIC_DEFAULT" # this is the default
  enable_key_rotation = true # rotate the key every 1 year
 # deletion_window_in_days = 10 # Optionally specify how many days to wait before deleting the key.
}

# Create an alias for the key
resource "aws_kms_alias" "my_kms_alias" {
  name          = var.key_alias
  target_key_id = aws_kms_key.my_kms_key.key_id