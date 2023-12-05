#!/bin/zsh

# Function to create a new IAM user
create_user() {
    local username=$1
    aws iam create-user --user-name "$username"
}

## Function to create a new IAM user profile
# Create a login profile (console access)
create_profile() {
    local username=$1
    local password=$2
    aws iam create-login-profile --user-name "$username" --password "$password" --password-reset-required
}

## Function to create a access key
create_access_key() {
    local username=$1
    aws iam create-access-key --user-name "$username" > "$username_access_key.json"
}

# Function to add user to a specified IAM group
add_user_to_group() {
    local username=$1
    local groupname=$2
    aws iam add-user-to-group --user-name "$username" --group-name "$groupname"
}

for arg in "$@"; do
    echo "Argument: $arg"
done

# Check if AWS CLI is installed
if ! type "aws" > /dev/null; then
    echo "AWS CLI is not installed. Please install it first."
    exit 1
fi

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <username> <password>"
    exit 1
fi

# Load the Terraform variable file output
MYDIR="$(dirname "$(readlink -f "$0")")"
source $MYDIR/variables.zsh

# Assign arguments to variables
USER=$1
PASSWORD=$2
GROUPNAME=$GROUP_NAME # the GROUP_NAME comes from the variables file

# Create new IAM user
create_user "$USER"

# Create the user profile
create_profile "$USER" "$PASSWORD"
# Add user to group
add_user_to_group "$USER" "$GROUPNAME"

# Create an access key
#create_access_key "$USER"

echo "User $USER has been created and added to the group $GROUPNAME."
