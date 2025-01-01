#!/bin/bash


# S3 bucket prefix to store the state file
export TG_BUCKET_PREFIX="scotts-"


# Run terragrunt to apply the Terraform configuration without any prompts
 terragrunt run-all --non-interactive apply -auto-approve
