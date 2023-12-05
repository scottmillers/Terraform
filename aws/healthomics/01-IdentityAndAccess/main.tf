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
        Action = [
          "omics:*"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "iam:PassRole"
        ],
        Effect   = "Allow",
        Resource = "*",
        Condition = {
          StringEquals = {
            "iam:PassedToService" : "omics.amazonaws.com"
          }
        }
      }
    ]
  })
}


# Attach IAM read only access to the group
# To allow creation of MFA and Access Keys in the console
resource "aws_iam_group_policy_attachment" "attach_iam_readonly_access" {
  group      = aws_iam_group.bioinformatics_group.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}


# Attach HealthOmics poliy to the group
resource "aws_iam_group_policy_attachment" "attach_omics" {
  group      = aws_iam_group.bioinformatics_group.name
  policy_arn = aws_iam_policy.omics_policy.arn
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
        Effect = "Allow",
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::${data.aws_s3_bucket.existing_bioinformatics_bucket.bucket}}",
          "arn:aws:s3:::${data.aws_s3_bucket.existing_bioinformatics_bucket.bucket}/*"
        ]
      }
    ]
  })
}

# The IAM policies to grant user access to the AWS HealthOmics
# https://docs.aws.amazon.com/omics/latest/dev/permissions-user.html
# Attach the s3 bucket policy to the group. 
resource "aws_iam_group_policy_attachment" "attach_omics_s3" {
  group      = aws_iam_group.bioinformatics_group.name
  policy_arn = aws_iam_policy.omics_s3_bucket_policy.arn
}

# Omics users needs access to cloudwatch logs if something goes wrong
resource "aws_iam_group_policy_attachment" "attach_iam_cloudwatchlogsfullaccess" {
  group      = aws_iam_group.bioinformatics_group.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

/*
# Attached EC2 Container Registry Full Access
# Used for workflow container images access
resource "aws_iam_group_policy_attachment" "attach_iam_ecrfullaccess" {
  group      = aws_iam_group.bioinformatics_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

# Attached Lake FormationDataAdmin
# Access to Lakeformation database and tables created by analytics stores
resource "aws_iam_group_policy_attachment" "attach_iam_lakeformationdataadminaccess" {
  group      = aws_iam_group.bioinformatics_group.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLakeFormationDataAdmin"
}

# Tag AWS HealthOmics resources with AWS HealthOmics tagging API operations
resource "aws_iam_group_policy_attachment" "attach_iam_resourcegroupsandtageditorfullaccess" {
  group      = aws_iam_group.bioinformatics_group.name
  policy_arn = "arn:aws:iam::aws:policy/ResourceGroupsandTagEditorFullAccess"
}
*/

# Create the service role for HealthOmics
# The service role is used by the AWS HealthOmics service to run workflows on your behalf.
# https://docs.aws.amazon.com/omics/latest/dev/permissions-service.html
resource "aws_iam_role" "omics_service_role" {
  name = "OmicsWorkflowServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "omics.amazonaws.com"
        },
      }
    ]
  })
}

# Service role policy needed to run Omics workflows
resource "aws_iam_policy" "omics_service_role_policy" {
  name        = "OmicsWorkflowServiceRolePolicy"
  description = "Policy for AWS HealthOmics service role"
  # Policy definition
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "omics:*",
          "ram:AcceptResourceShareInvitation",
          "ram:GetResourceShareInvitations"
        ],
        Resource = "*"
        Effect   = "Allow"
      },
      {
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::${data.aws_s3_bucket.existing_bioinformatics_bucket.bucket}}",
          "arn:aws:s3:::${data.aws_s3_bucket.existing_bioinformatics_bucket.bucket}/*",
          "arn:aws:s3:::omics-us-east-1",
          "arn:aws:s3:::omics-us-east-1/*",
        ]
        Effect = "Allow",
      },
      {
        Action = [
          "logs:CreateLogStream",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents"
        ],
        Resource = [
          "arn:aws:logs:us-east-1:588459062833:log-group:/aws/omics/WorkflowLog:log-stream:*"
        ],
        Effect = "Allow"
      },
      {
        Action = [
          "logs:CreateLogGroup"
        ],
        Resource = [
          "arn:aws:logs:us-east-1:588459062833:log-group:/aws/omics/WorkflowLog:*"
        ],
        Effect = "Allow"
      }
    ]
  })
}

// Attach the service policy to the service role
resource "aws_iam_role_policy_attachment" "omics_service_role_describe" {
  role       = aws_iam_role.omics_service_role.name
  policy_arn = aws_iam_policy.omics_service_role_policy.arn
}














