#!/bin/bash
# Get a list of linux2 amis keys from System Service Manager
aws ssm get-parameters-by-path --path /aws/service/ami-amazon-linux-latest --query Parameters[].Name