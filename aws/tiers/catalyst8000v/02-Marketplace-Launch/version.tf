terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      region = var.region
      source  = "hashicorp/aws"
      version = ">= 5.9"
    }
  
  }
}


