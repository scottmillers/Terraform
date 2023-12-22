

# Create an S3 bucket
resource "aws_s3_bucket" "sample" {
  bucket = "my-learning-s3-bucket-sample"
  force_destroy = true   # delete the bucket even if it has objects in it
}


# Enable versioning
resource "aws_s3_bucket_versioning" "sample_version" {
  bucket = aws_s3_bucket.sample.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Setup Lifecycle rules
# Lifecyle rule to move log files that are in 
# log directories with tags rule=log and autoclean=true to
# Standard infrequent access: After 30 days
# Glacier Flexible Retrieval: After 60 days
# Glacier Deep Archive: After 365 days
# Delete after 5 years, or 1825 days
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-rules.html
resource "aws_s3_bucket_lifecycle_configuration" "sample_lifecycle_config" {
  bucket = aws_s3_bucket.sample.id
 

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
