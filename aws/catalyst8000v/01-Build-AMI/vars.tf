variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Bucket name to store the Cisco software"
  type        = string
  default     = "cisco-8000v-software"
}


# You need to change this.  I am using my dev container mounted host filesystem to access files.  
variable "file_path" {
  description = "Local path to the directory for the files to upload"
  type        = string
  default     = "/host-home-folder/Downloads/cisco8000v/c8000v-universalk9_vga.V177_1A_CSCWE66776_2/"
}


