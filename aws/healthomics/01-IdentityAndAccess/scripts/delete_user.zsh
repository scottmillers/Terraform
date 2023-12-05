#!/bin/zsh

# Function to delete an IAM user
delete_user() {
    local username=$1

    # Delete the user
    aws iam delete-user --user-name "$username"
}
# Function to delete an IAM user's login profile
delete_login_profile() {
    local username=$1

    # Delete the user's login profile
    aws iam delete-login-profile --user-name "$username"
}

# Function to delete an IAM user's access key
delete_access_key() {
    local username=$1
    local access_key_id=$2

    # Delete the access key
    aws iam delete-access-key --user-name "$username" --access-key-id "$access_key_id"
}

# Function to remove a user from a group
remove_user_from_group() {
    local username=$1
    local groupname=$2

    # Remove the user from the group
    aws iam remove-user-from-group --user-name "$username" --group-name "$groupname"
}


# Check if AWS CLI is installed
if ! type "aws" > /dev/null; then
    echo "AWS CLI is not installed. Please install it first."
    exit 1
fi

# Check if the username is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi


# Load the Terraform variable file output
MYDIR="$(dirname "$(readlink -f "$0")")"
source $MYDIR/variables.zsh

# Assign arguments to variables
USER=$1
GROUPNAME=$GROUP_NAME # the GROUP_NAME comes from the variables file

# Assign the first argument to USERNAME
USER=$1

# Remove the user from the group
remove_user_from_group "$USER" "$GROUPNAME"

# Delete their access key
#delete_access_key "$USER" "AKIAYSAXEWYYRG2OPA6S"

# Remove their login profile
delete_login_profile "$USER"

# Delete the user
delete_user "$USER"

#echo "User $USER has been deleted."
