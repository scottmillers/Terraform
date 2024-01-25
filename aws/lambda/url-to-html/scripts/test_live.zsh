#!/bin/zsh
# Script will:
# 1. Call the live alias lambda with parameters
# 2. Verify the results are what is expected

MYDIR="$(dirname "$(readlink -f "$0")")"

source $MYDIR/variables.zsh

# Define the URL of the Lambda Public endpoint to call
url="$PROD_ALIAS_URL?url=https://news.ycombinator.com&name=hackernews"


# Define the expected JSON response
expected_response='{"title":"Hacker News","s3_url":"https://storage-for-lambda-url-to-html.s3.amazonaws.com/hackernews.html"}'

# Call the URL and retrieve the JSON response
response=$(curl -s "$url")

# Compare the response with the expected value
if [[ "$response" == "$expected_response" ]]; then
    echo "Success! Response matches the expected value"
    echo "Here is the response:"
    echo $response
else
    echo "Fail! Response does not match the expected value"
fi
