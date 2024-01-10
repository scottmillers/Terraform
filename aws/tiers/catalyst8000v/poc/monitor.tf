###############################################
# EC2 instance monitoring with CloudWatch Agent
###############################################


######################################
# Network Monitoring using Flow Logs
######################################

resource "aws_iam_role" "flow_log_role" {
  name = "flow_log_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_role_policy" "flow_log_policy" {
  name = "flow_log_policy"
  role = aws_iam_role.flow_log_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
    ],
  })
}

# Create a cloud logwatch for the flow log
resource "aws_cloudwatch_log_group" "network" {
  name = "/aws/vpc/network_flow_log"
}

# Create the flow-log
resource "aws_flow_log" "network" {
  iam_role_arn    = aws_iam_role.flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.network.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.network.id
  depends_on = [ aws_flow_log.network ]  # adding this to delete the log group with the flow_log
}



