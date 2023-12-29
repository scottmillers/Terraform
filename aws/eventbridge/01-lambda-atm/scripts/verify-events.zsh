#!/bin/zsh

MYDIR="$(dirname "$(readlink -f "$0")")"

source $MYDIR/variables.zsh

# Specify the name of the DynamoDB table
#table_name="your-table-name"

# Use the AWS CLI to scan the table and count the number of records
#record_count=$(aws dynamodb scan --table-name $APPROVED_TRANSACTION_TABLE --select "COUNT" --output text --query "Count")

# Print the record count
#echo "Number of records in $APPROVED_TRANSACTION_TABLE: $record_count"

# This will look for the actual record
#aws dynamodb query \
#    --table-name $APPROVED_TRANSACTION_TABLE \
#    --key-condition-expression "Account = :accountVal" \
#    --expression-attribute-values '{":accountVal":{"S":"0000000000000000"}}' \
#    --output text

#aws dynamodb execute-statement \
#    --statement "SELECT COUNT * FROM $APPROVED_TRANSACTION_TABLE WHERE Account IN ['0000000000000000','9999999999999999']" 
   
record_count=$(aws dynamodb scan --table-name $APPROVED_TRANSACTION_TABLE --select "COUNT" --output text --query "Count")

if [ "$record_count" -eq 2 ]; then
    echo "$APPROVED_TRANSACTION_TABLE count of $record_count is correct!"
else
    echo "Fail"
fi

record_count=$(aws dynamodb scan --table-name $NY_TRANSACTION_TABLE --select "COUNT" --output text --query "Count")

if [ "$record_count" -eq 2 ]; then
    echo "$NY_TRANSACTION_TABLE count of $record_count is correct!"
else
    echo "Fail"
fi

record_count=$(aws dynamodb scan --table-name $FAILED_TRANSACTION_TABLE --select "COUNT" --output text --query "Count")

if [ "$record_count" -eq 1 ]; then
    echo "$FAILED_TRANSACTION_TABLE count of $record_count is correct!"
else
    echo "Fail"
fi

