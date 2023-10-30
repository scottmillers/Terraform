# get the existing Bioinformatics S3 bucket ARN
output "bucket_arn" {
  value = data.aws_s3_bucket.existing_bioinformatics_bucket.arn
}


output "iam_group_name" {
  value = aws_iam_group.bioinformatics_group.name
}
