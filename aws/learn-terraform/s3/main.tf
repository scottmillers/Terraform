# Create an S3 bucket
resource "aws_s3_bucket" "quarterly" {
  bucket = "my-learning-s3-bucket-quarterly"
}



resource "aws_s3_bucket_versioning" "quarterly_version" {
  bucket = aws_s3_bucket.quarterly.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Lifecyle rule to move log files that are in 
# log directories with tags rule=log and autoclean=true to
# Standard infrequent access: After 30 days
# Glacier Flexible Retrieval: After 60 days
# Glacier Deep Archive: After 365 days
# Delete after 5 years, or 1825 days
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-rules.html
resource "aws_s3_bucket_lifecycle_configuration" "quarterly_lifecycle_config" {
  bucket = aws_s3_bucket.quarterly.id

  rule {
    id = "log"


    expiration {
      days = 1825
    }

    filter {
      and {
        prefix = "log/"

        tags = {
          rule      = "log"
          autoclean = "true"
        }
      }
    }

    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    transition {
      days          = 365
      storage_class = "DEEP_ARCHIVE"
    }
  }

  rule {
    id = "tmp"

    filter {
      prefix = "tmp/"
    }

    expiration {
      date = "2024-01-13T00:00:00Z"
    }

    status = "Enabled"
  }
}

/*
resource "aws_s3_bucket" "permanent" {
  bucket = "my-learning-s3-bucket-permanent"
  acl    = "private"

  # Enable versioning
  versioning {
    enabled = true
  }

  # Add a lifecycle rule to transition objects to Glacier storage class after 30 days
  lifecycle_rule {
    id      = "permanent_retention"
    prefix = "permanent/"
    enabled = true

    transition {
      days          = 10
      storage_class = "GLACIER"
    }
  }
}
*/
