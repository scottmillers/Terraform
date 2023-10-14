variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Bucket name to store the OVA file"
  type        = string
  default     = "cisco-8000v-image"
}

variable file_name {
  description = "File to upload"
  type        = string
  default     = "c8000v-universalk9_vga.V177_1A_CSCWE66776_2.ova"

}

variable "file_path" {
  description = "Local path for the file to upload"
  type        = string
  default     = "/host-home-folder/Downloads/"
}


