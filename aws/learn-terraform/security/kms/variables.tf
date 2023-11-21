variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "key_alias" {
  description = "KMS key alias"
  type        = string
  default     = "alias/learn-terraform-kms-key"
  
}
