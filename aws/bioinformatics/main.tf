# name of the existing bioinformatics bucket for lookups
data "aws_s3_bucket" "existing_bioinformatics_bucket" {
  bucket = "bioinformatics-nbs"
}


# create the bioinformatics group
resource "aws_iam_group" "bioinformatics_group" {
  name = "bioinformatics-group"
}

# Policy to allow a user to all AWS HealthOmics API actions and pass service roles to AWS HealthOmics
# https://docs.aws.amazon.com/omics/latest/dev/permissions-user.html
resource "aws_iam_policy" "omics_policy" {
  name        = "BioinformaticsOmicsPolicy"
  description = "Allow Bioinformatics full access to AWS HealthOmics"
  # Policy definition
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = [
          "omics:*"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action   = [
          "iam:PassRole"
        ],
        Effect   = "Allow",
        Resource = "*",
        Condition = {
          StringEquals = {
            "iam:PassedToService": "omics.amazonaws.com"
          }
        }
      }
    ]
  })
}

# Policy to allow a user to all AWS HealthOmics API actions and pass service roles to AWS HealthOmics
# https://docs.aws.amazon.com/omics/latest/dev/permissions-user.html
resource "aws_iam_policy" "omics_s3_bucket_policy" {
  name        = "BioinformaticsOmicsS3Policy"
  description = "Allow Bioinformatics access to S3 bucket"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:*",
        Resource = [
          "arn:aws:s3:::${data.aws_s3_bucket.existing_bioinformatics_bucket.bucket}}",
          "arn:aws:s3:::${data.aws_s3_bucket.existing_bioinformatics_bucket.bucket}/*"
        ]
      }
    ]
  })
}


# Attach omics poliy to the group
resource "aws_iam_group_policy_attachment" "attach_omics" {
  group      =  aws_iam_group.bioinformatics_group.name
  policy_arn = aws_iam_policy.omics_policy.arn
}

# Attach the s3 bucket policy to the group
resource "aws_iam_group_policy_attachment" "attach_omics_s3" {
  group      = aws_iam_group.bioinformatics_group.name
  policy_arn = aws_iam_policy.omics_s3_bucket_policy.arn
}

# Attach IAM read only access to the group
resource "aws_iam_group_policy_attachment" "attach_iam_readonly_access" {
  group      = aws_iam_group.bioinformatics_group.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}










