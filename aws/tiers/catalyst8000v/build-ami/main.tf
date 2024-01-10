
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name # this name has to be unique globally
}

# upload all files from the local directory to the S3 bucket
resource "aws_s3_object" "file_upload" {
  for_each = fileset(var.file_path, "*")
  source = "${var.file_path}${each.value}"
  bucket = aws_s3_bucket.my_bucket.id
  key    = each.value
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("${var.file_path}${each.value}")
}

# Required permissions for VM Import/Export
# https://docs.aws.amazon.com/vm-import/latest/userguide/required-permissions.html
resource "aws_iam_role" "vm_import" {
  name = "vmimport"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "vmie.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "vm_import" {
  name = "vm-import-role-policy"
  role = aws_iam_role.vm_import.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetBucketAcl"
        ],
        Resource = [
          aws_s3_bucket.my_bucket.arn,
          "${aws_s3_bucket.my_bucket.arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:ModifySnapshotAttribute",
          "ec2:CopySnapshot",
          "ec2:RegisterImage",
          "ec2:Describe*"
        ],
        Resource = "*"
      }
    ]
  })
}


