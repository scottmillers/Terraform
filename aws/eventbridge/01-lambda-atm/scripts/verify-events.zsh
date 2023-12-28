#!/bin/zsh

MYDIR="$(dirname "$(readlink -f "$0")")"

source $MYDIR/variables.zsh

# Specify the name of the DynamoDB table
#table_name="your-table-name"

# Use the AWS CLI to scan the table and count the number of records
record_count=$(aws dynamodb scan --table-name $APPROVED_TRANSACTION_TABLE --select "COUNT" --output text --query "Count")

# Print the record count
echo "Number of records in $APPROVED_TRANSACTION_TABLE: $record_count"
