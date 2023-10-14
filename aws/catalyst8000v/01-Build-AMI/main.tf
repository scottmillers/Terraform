
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name # this name has to be unique globally
}

resource "aws_s3_object" "file_upload" {
  bucket      = aws_s3_bucket.my_bucket.bucket
  key         =  var.file_name
  source      =  "${var.file_path}${var.file_name}"
  source_hash = filemd5("${var.file_path}${var.file_name}")
}


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


